Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbRGTOGB>; Fri, 20 Jul 2001 10:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRGTOFv>; Fri, 20 Jul 2001 10:05:51 -0400
Received: from mail.zmailer.org ([194.252.70.162]:53509 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S266938AbRGTOFf>;
	Fri, 20 Jul 2001 10:05:35 -0400
Date: Fri, 20 Jul 2001 17:05:35 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Nikita Danilov <NikitaDanilov@Yahoo.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to fs/proc/base.c
Message-ID: <20010720170535.Z5559@mea-ext.zmailer.org>
In-Reply-To: <15192.14679.866099.871164@beta.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15192.14679.866099.871164@beta.namesys.com>; from NikitaDanilov@Yahoo.COM on Fri, Jul 20, 2001 at 05:59:51PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 20, 2001 at 05:59:51PM +0400, Nikita Danilov wrote:
> Date:	Fri, 20 Jul 2001 17:59:51 +0400
> From:	Nikita Danilov <NikitaDanilov@Yahoo.COM>
> To:	linux-kernel@vger.kernel.org
> Subject: patch to fs/proc/base.c
> 
> Hello, 
> 
> following patch cures oopses in 2.4.7-pre9 when 
> proc_pid_make_inode() is called on task with task->mm == NULL.
> 
> Linus, please apply, if you haven't got a bunch of equivalent patches
> already, which is doubtful.

   He won't.  For two reasons:
	- There is better fix which Linus himself posted some hours ago
	- Linus does not read (directly)  linux-kernel  list.

> Nikita.

/Matti Aarnio
