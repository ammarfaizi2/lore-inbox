Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWBKT4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWBKT4X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 14:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWBKT4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 14:56:23 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:64398 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964786AbWBKT4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 14:56:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=cxmQht7sPfG4qJpz+y2dnZuqLln4LCaJGcGxEOI/rR+2c1zgJr0fFI9SHpJbMSG4hUGzjlIdivLVibOpKdypf29Rd72/nLqpdSl00L5yVuiE1NRVj6qYRBqAWehkIRrj2Enz09Y6qJ5Cc6EWo9ygXvtuocFBq99+0zjhaVFs11E=
Message-ID: <43EE415F.2000805@gmail.com>
Date: Sat, 11 Feb 2006 20:56:15 +0100
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: old patches in -mm
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

There are 35 patches(not included reiser4 and post-halloween-doc) older
than 2 months that still are not in mainline. Forgotten or experimental ?


2.6-sony_acpi4.patch
acx1xx-allow-modular-build.patch
acx1xx-wireless-driver-spy_offset-went-away.patch
acx1xx-wireless-driver-usb-is-bust.patch
acx-should-select-not-depend-on-fw_loader.patch
acx-update-2.patch
acx-update.patch
debug-warn-if-we-sleep-in-an-irq-for-a-long-time.patch
dlm-build-fix-2.patch
dlm-build-fix.patch
dlm-communication-fix-lowcomms-race.patch
dlm-core-locking-resend-lookups.patch
dlm-device-interface-dlm-force-unlock.patch
dlm-device-interface-fix-device-refcount.patch
dlm-recovery-clear-new_master-flag.patch
dlm-recovery-make-code-static.patch
dlm-use-configfs-fix-2.patch
dlm-use-configfs-fix.patch
documentation-ioctl-messtxt-add-260-more-ioctls.patch
documentation-ioctl-messtxt-document-85-more-ioctls.patch
documentation-ioctl-messtxt-fill-more-holes-in-b-p-range.patch
documentation-ioctl-messtxt-start-annotating-i-o.patch
drivers-net-wireless-tiacx-add-missing-include-linux-vmallocha.patch
export-file_ra_state_init-again.patch
fbdev-update-framebuffer-feature-list.patch
firestream-warnings.patch
fs-asfs-make-code-static.patch
journal_add_journal_head-debug.patch
nr_blockdev_pages-in_interrupt-warning.patch
nvidia-agp-use-time_before_eq.patch
oops-reporting-tool.patch
releasing-resources-with-children.patch
remove-checkconfigpl.patch
slab-cache-shrinker-statistics-fix.patch
tiacx-usb_driver-build-fix.patch


-thanks-

-- 
Politicos de mierda, yo no soy un terrorista.
