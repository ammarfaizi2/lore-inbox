Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVAQTMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVAQTMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVAQTMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:12:45 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:26846 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262617AbVAQTMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:12:44 -0500
Date: Mon, 17 Jan 2005 20:12:41 +0100
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] FAT: Lindent fs/vfat/namei.c
Message-ID: <20050117191241.GD25205@speedy.student.utwente.nl>
References: <87pt04oszi.fsf@devron.myhome.or.jp> <87llasosxu.fsf@devron.myhome.or.jp> <87hdlgoswe.fsf_-_@devron.myhome.or.jp> <87d5w4osuv.fsf_-_@devron.myhome.or.jp> <878y6sostl.fsf_-_@devron.myhome.or.jp> <874qhgosrf.fsf_-_@devron.myhome.or.jp> <87zmz8ne5p.fsf_-_@devron.myhome.or.jp> <877jmcne0o.fsf_-_@devron.myhome.or.jp> <873bx0ndze.fsf_-_@devron.myhome.or.jp> <87y8eslzdq.fsf_-_@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8eslzdq.fsf_-_@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040907i
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 02:49:21AM +0900, OGAWA Hirofumi wrote:
> diff -puN fs/vfat/namei.c~fat_lindent-vfat fs/vfat/namei.c
> --- linux-2.6.10/fs/vfat/namei.c~fat_lindent-vfat	2005-01-10 01:57:31.000000000 +0900
> +++ linux-2.6.10-hirofumi/fs/vfat/namei.c	2005-01-10 01:57:44.000000000 +0900
> @@ -12,7 +12,7 @@
>   *  Short name translation 1999, 2001 by Wolfram Pienkoss <wp@bszh.de>
>   *
>   *  Support Multibyte character and cleanup by
                                ^^^ Shouldn't that be 'characters'?

Yup, that was it.. sorry if I'm nitpicking :-P

Sytse
