Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVBFTaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVBFTaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVBFTaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:30:46 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:19659 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261280AbVBFTam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:30:42 -0500
Date: Sun, 6 Feb 2005 20:30:35 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavenis@latnet.lv
Subject: Re: [PATCH] Bug in tty_io.c after changes between 2.6.9-rc1-bk1 and 2.6.9-rc1-bk2
Message-ID: <20050206193035.GA27126@suse.de>
References: <200502021844.j12IilJJ029973@hera.kernel.org> <20050206182845.GA24803@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050206182845.GA24803@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Feb 06, Olaf Hering wrote:

> Do you have an outdated udev package with bogus udev.rules?

Your strace clearly shows /dev/tty as a directory.
Go and ask Linus to revert your broken patch.
