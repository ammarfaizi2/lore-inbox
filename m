Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVCHMj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVCHMj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCHMj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:39:57 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:55243 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262023AbVCHMjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:39:49 -0500
Date: Tue, 8 Mar 2005 14:38:33 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: Gerd Knorr <kraxel@bytesex.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>,
       dvb list <linux-dvb@linuxtv.org>
Subject: Re: [patch] v4l: MAINTAINERS file update.
In-Reply-To: <20050308112525.GA31360@bytesex>
Message-ID: <Pine.LNX.4.62.0503081438160.12645@webhosting.rdsbv.ro>
References: <20050308112525.GA31360@bytesex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Gerd Knorr wrote:

>  Hi folks,
>
> Goodbye, and that thanks for all the fish ;)
>
> After several years of v4l maintainance I'm going to switch
> to a new work field and will not be able to spend much time
> on maintaining video4linux and the drivers, so someone else
> will have to step in.
>
> I will not suddenly disappear from earth, I will be available
> for questions and patch reviews for some time, but I'll stop
> doing active development and most likely will not have the
> time to act as central patch relay for all video4linux stuff.

Hi!

We will miss you!
Thank for all your work!

>
> cheers,
>
>  Gerd
>
> Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
> ---
> MAINTAINERS |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>
> Index: linux-2.6.11/MAINTAINERS
> ===================================================================
> --- linux-2.6.11.orig/MAINTAINERS	2005-03-07 10:14:21.000000000 +0100
> +++ linux-2.6.11/MAINTAINERS	2005-03-07 18:13:48.000000000 +0100
> @@ -501,7 +501,7 @@ P:	Gerd Knorr
> M:	kraxel@bytesex.org
> L:	video4linux-list@redhat.com
> W:	http://bytesex.org/bttv/
> -S:	Maintained
> +S:	Orphan
>
> BUSLOGIC SCSI DRIVER
> P:	Leonard N. Zubkoff
> @@ -2534,7 +2534,8 @@ S:	Maintained
> VIDEO FOR LINUX
> P:	Gerd Knorr
> M:	kraxel@bytesex.org
> -S:	Maintained
> +L:	video4linux-list@redhat.com
> +S:	Orphan
>
> W1 DALLAS'S 1-WIRE BUS
> P:	Evgeniy Polyakov
>
> -- 
> #define printk(args...) fprintf(stderr, ## args)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
