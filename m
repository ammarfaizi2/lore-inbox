Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVGLJnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVGLJnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVGLJnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:43:23 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:4527 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261301AbVGLJmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:42:06 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Userspace accelerometer viewer)
In-Reply-To: <20050711151330.GB2001@elf.ucw.cz>
References: <42C7A3B2.4090502@linuxwireless.org> <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net> <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net> <20050711151330.GB2001@elf.ucw.cz>
Date: Tue, 12 Jul 2005 10:41:45 +0100
Message-Id: <E1DsHGr-0005Jf-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:

> Oh, very nice pictures indeed...  What is the current interface
> between userspace and kernel parts?

This one is implemented entirely in userspace, with stdio between the io
application and the 3D viewer.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
