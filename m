Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVCFSLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVCFSLy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVCFSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 13:11:53 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:2327 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261456AbVCFSLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 13:11:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=pQ+RXQJBTTuJCXN1UZlgH+Ln7ElKkbsrpsbFpoP/XYNEL6OQq1guLKLVuXFU70OlDOsPwrtSoJQKfv9Q5wHwSoW4lalOxVvax3dw03U+wzocz5aEXD36Nt3US6BrEgloGQUtdGYoo5dSqtsolN8FhTgpmjErW4yAorK/o7+ZgGc=
Message-ID: <9e47339105030610113d00f9f7@mail.gmail.com>
Date: Sun, 6 Mar 2005 13:11:48 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: PCI Express and legacy ISA/VGA support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can a PCI Express expert enlighten me on how VGA support happens on
PCI Express?

1) Does VGA work on PCI Express?
2) Is it routed at bridges like x86 PCI?
3) Or does each bridge have it's own legacy space like PCI on 64b machines?
4) How are other things like serial ports handled?
5) What about the VGA memory window at A000:0?

-- 
Jon Smirl
jonsmirl@gmail.com
