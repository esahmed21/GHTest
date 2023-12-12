import GitHubUI
import Lists
import Palette
import SnapKit
import UIKit
final class DeploymentCheckRunCell: UITableViewCell, Bindable { final class DeploymentCheckRunCell: UITableViewCell, Bindable { final class DeploymentCheckRunCell: UITableViewCell, Bindable {

final class DeploymentCheckRunCell: UITableViewCell, Bindable {final class DeploymentCheckRunCell: UITableViewCell, Bindable {




    private let leadingIconImageView = applying(UIImageView(), compose(
        Palette.image(Asset.workflow24.image),
        Palette.tintColor(Asset.iconPrimary.color)
    ))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(leadingIconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(trailingTitleLabel)

        leadingIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(DeploymentCheckRunCell.iconSize)
            make.leading.centerY.equalTo(contentView.layoutMarginsGuide)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview().offset(grid(4))
            make.bottom.lessThanOrEqualToSuperview().offset(grid(-4))
            make.centerY.equalTo(leadingIconImageView)
            make.leading.equalTo(leadingIconImageView.snp.trailing).offset(grid(4))
            make.trailing.lessThanOrEqualTo(trailingTitleLabel.snp.leading)
        }

        trailingTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.trailing.equalTo(contentView.layoutMarginsGuide).offset(grid(-3))
        }

        let border = UIView()
        border.backgroundColor = Asset.border.color
        addSubview(border)
        border.snp.makeConstraints { make in
            make.height.equalTo(1.0 / UIScreen.main.scale)
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var rotateAnimation: CABasicAnimation = {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi * 2.0
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = .infinity
        rotateAnimation.isRemovedOnCompletion = false
        return rotateAnimation
    }()
        private static let iconSize = grid(5)

    private let titleLabel = applying(UILabel(), compose(
        Palette.numberOfLines(0),
        Palette.textColor(Asset.textPrimary.color),
        Palette.font(.preferredFont(forTextStyle: .body))
    ))

    private let trailingTitleLabel = applying(UILabel(), compose(
        Palette.numberOfLines(0),
        Palette.textColor(Asset.textTertiary.color),
        Palette.font(.preferredFont(forTextStyle: .callout))
    ))

    func bind(viewModel: CheckRunViewModel) {
        titleLabel.text = viewModel.name
        leadingIconImageView.tintColor = viewModel.iconColor
        leadingIconImageView.image = viewModel.statusIcon
        trailingTitleLabel.text = viewModel.statusLabel
        trailingTitleLabel.textColor = viewModel.statusColor
        if viewModel.isAnimating {
            if leadingIconImageView.layer.animation(forKey: "transform.rotation") == nil {
                leadingIconImageView.layer.add(rotateAnimation, forKey: "transform.rotation")
            }
        } else {
            leadingIconImageView.layer.removeAnimation(forKey: "transform.rotation")
        }
    }
}
