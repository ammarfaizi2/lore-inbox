Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbVIPRjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbVIPRjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbVIPRjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:39:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32735 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161203AbVIPRjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:39:11 -0400
Date: Fri, 16 Sep 2005 19:38:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatic Configuration of a Kernel
Message-ID: <20050916173848.GA9570@elf.ucw.cz>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <6bffcb0e05091415533d563c5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e05091415533d563c5a@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I wrote this Framework for making a .config based on
> > the System Hardwares. It would be a great help if some
> > people would give me their opinion about it.
> > 
> > Regards
> 
> It's for new linux users? They should use distributions kernels.
> It's for "power users"? They just do make menuconfig...
> It's for kernel developers? They just do vi .config.

Actually its "emacs .config" :-). But tool to help would be nice. For
development, minimum config is nice (compiles fast), and creating
config from scratch is quite painfull.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
