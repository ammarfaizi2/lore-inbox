Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271168AbUJVCgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271168AbUJVCgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271193AbUJVCNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:13:06 -0400
Received: from [12.177.129.25] ([12.177.129.25]:63427 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S271198AbUJVCKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:10:00 -0400
Message-Id: <200410220319.i9M3JSFL007319@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Chris Wedgwood <cw@f00f.org>
cc: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] UML: INITRAMFS_SOURCE noise/build fix 
In-Reply-To: Your message of "Wed, 20 Oct 2004 19:40:54 PDT."
             <20041021024054.GA17968@taniwha.stupidest.org> 
References: <20041021024054.GA17968@taniwha.stupidest.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Oct 2004 23:19:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cw@f00f.org said:
> Trivial patch (copy & yank) so UML builds don't generate a warning
> from linux/usr/Makefile:gen_cmd_list when CONFIG_INITRAMFS_SOURCE
> isn't defined (maybe the Makefile shouldn't require
> CONFIG_INITRAMFS_SOURCE to be set?). 

Applied, thanks.

I hadn't got around to figuring out what that error was about.

				Jeff

