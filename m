Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUKUAjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUKUAjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbUKUAgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:36:17 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:52637 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261661AbUKUAen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:34:43 -0500
To: diegocg@gmail.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <20041121003755.3342a1cb.diegocg@gmail.com> (message from Diego
	Calleja on Sun, 21 Nov 2004 00:37:55 +0100)
Subject: Re: [PATCH 3/13] Filesystem in Userspace
References: <E1CVeML-0007PA-00@dorka.pomaz.szeredi.hu> <20041121003755.3342a1cb.diegocg@gmail.com>
Message-Id: <E1CVfgb-0007Ze-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 01:34:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     - adds /sys/fs/fuse/version
> 
> If FUSE is going to be included in the kernel, would you really need that?
>  
> If something it's in mainline "kernel version 2.6.56" is enought to describe
> what code people are running.

It's not for people, but for the library.  It's the version of the
userspace-kernel interface.

Miklos
