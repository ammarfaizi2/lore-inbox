Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVDBCSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVDBCSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbVDBCSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:18:08 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:46810 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262965AbVDBCSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:18:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=DivM4jCLHDvCBUFJc6UF0x48XSIAtjCWQCSDtAFzQ2oCV6/MkNM7qy8j2au0BvC9PLLxi08KFZkvj0FovBNSLm6iZ4+yT/l4hZfVp4MIMu4DSr18xyU+It9jwxtiVokPiGJinKSk9i4m99Yn6qSCYfNiNfG2p2AMejXXbZQDpLU=
Message-ID: <9e473391050401181824d9e50f@mail.gmail.com>
Date: Fri, 1 Apr 2005 21:18:03 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: initramfs linus tree breakage in last day
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot the kernel is mistaking my initrd as an initramfs. Of
course this doesn't work. This broke in the last 24hrs on the linus bk
tree. I am using an up2date Fedora Core 3. Booting older kernels still
works.


-- 
Jon Smirl
jonsmirl@gmail.com
