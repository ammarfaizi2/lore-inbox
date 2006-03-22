Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422629AbWCWQVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422629AbWCWQVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWCWQVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:21:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25864 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161003AbWCWQVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:21:06 -0500
Date: Wed, 22 Mar 2006 15:58:04 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Amit Luniya <amit_31_08@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help for problem related to hibernation in linux kernel 2.6.14.5 kernel
Message-ID: <20060322155803.GA2401@ucw.cz>
References: <20060321054552.64884.qmail@web8712.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321054552.64884.qmail@web8712.mail.in.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     I am a final year student of computer enggineering
> from pune university.
> I am working on project of hibernation in network
> environment that means client image is saved onto
> server
> and when required get it from server.We are utilising
> the 
> code of hibernation that is written in swsusp.c and
> disk.c files in linux kernel 2.6.14.5. 
>   Problem is that existing code of hibernation does
> not support ping or any network related services after
> resume from suspending.So due to this problem we cant
> communicate with server and can not  get image back
> from server. So what we should do to overcome from
> this problem?

See suspend.sf.net, saving image over net should be easy from
userland.



Thanks, Sharp!
