Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262338AbSIPPwt>; Mon, 16 Sep 2002 11:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbSIPPwt>; Mon, 16 Sep 2002 11:52:49 -0400
Received: from cibs9.sns.it ([192.167.206.29]:54028 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S262338AbSIPPwr>;
	Mon, 16 Sep 2002 11:52:47 -0400
Date: Mon, 16 Sep 2002 17:57:08 +0200 (CEST)
From: venom@sns.it
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Mark Veltzer <mark@veltzer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hi is this critical??
In-Reply-To: <1032185694.7129.21.camel@bip>
Message-ID: <Pine.LNX.4.43.0209161756080.5976-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If so, why not to use S.M.A.R.T with smartd and smartctl?
I think you will like them (loock on freshmeat for the link).


On 16 Sep 2002, Xavier Bestel wrote:

> Date: 16 Sep 2002 16:14:54 +0200
> From: Xavier Bestel <xavier.bestel@free.fr>
> To: Mark Veltzer <mark@veltzer.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Hi is this critical??
>
> Le lun 16/09/2002 à 16:16, Mark Veltzer a écrit :
>
> > 2. The user who posted the question is under no circumstances a "looser"
> > (mind the oo instead of the u...). His question is very valid and the fact
> > that he read dmesg puts him way past any standard computer user.
>
> Well, actually I didn't want to depict *him* as a looser. I was talking
> about me :) I've already been confronted with message from the IDE
> drivers (and that's when I see them. I'm not always at the console or
> reading syslog) and I never remember if they are critical or harmless. I
> have to either dig through lkml archives to find what they mean, or ask
> lkml what do they mean (to the luser I am).
>
> IDE error/status message aren't visible enough. I'd like to know when my
> drive is near failing, without looking at syslog.
>
> 	Xav - luser
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

