Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWFZEye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWFZEye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 00:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWFZEye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 00:54:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36853 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965052AbWFZEye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 00:54:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ssOqAPQq+9yxjOboda/qnrzQ7jJ2iE7tFzC/x0FIA6MMSqJtdrRcRVzOFR8aNjH/4NJkT/XMZTm34gnZYq7k5z+HgZpTzZ3RzAwdtqisrRhEpWbuxLy+y1j6sahU0dsSqWB02Tfod8fhJMSTSl3KKgr+D3IOZ/Upk7yFc/e2/cU=
Message-ID: <b6a2187b0606252154i42b031c7tbc72235e5ad4313c@mail.gmail.com>
Date: Mon, 26 Jun 2006 12:54:31 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2GB or 4GB SD support for Linux 2.6.17?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried both 2GB and 4GB SD card on 2.6.17 and both failed. But 1GB works fine.

Thanks,
Jeff.


sdhci: Secure Digital Host Controller Interface driver, 0.11
sdhci: Copyright(c) Pierre Ossman
mmc0: SDHCI at 0xe4301800 irq 23 PIO
mmcblk0: mmc0:b368 SD    2009600KiB
 mmcblk0:<3>mmcblk0: error 2 transferring data
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
mmcblk0: error 2 transferring data
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
 unable to read partition table
mmcblk0: mmc0:b368 SD    4020224KiB
 mmcblk0:<3>mmcblk0: error 2 transferring data
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
mmcblk0: error 2 transferring data
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
 unable to read partition table
