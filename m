Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWAREpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWAREpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 23:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAREpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 23:45:42 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:25814 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964934AbWAREpm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 23:45:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ELBYrnfu9wyYEcywo9i6hue48nZKTgMDvK9XZO6qZCqVvWizGMWPAkdqkVyeiI3NaiZ+qPy93DQqeBKoL+gZxro4Ihd/CsMsqaZcAaLxhcPdQSF11LsxOgbDQF1Je/u+nKSm6i9YIK2ZDHjL9lFaiuwTFbtuF7wzMD5FWDICwIk=
Message-ID: <7cd5d4b40601172045j531a21b3y41db1dfbf84b769f@mail.gmail.com>
Date: Wed, 18 Jan 2006 12:45:41 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: userspace filesystem Vs kernelspace filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,everyone!

Linux kernel provides vfs for the various physical filesystems.The
profit we get from the
VFS is just the standard interface it provides such as read and write?

Can we implement a user space filesystem which is actually a library?I
think it will be
faster than kernel space filesystem through the vfs layer.

Any suggestions or commnets?

Thank you!
