Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbRFKVgP>; Mon, 11 Jun 2001 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbRFKVgG>; Mon, 11 Jun 2001 17:36:06 -0400
Received: from flodhest.stud.ntnu.no ([129.241.56.24]:39673 "EHLO
	flodhest.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S262242AbRFKVfu>; Mon, 11 Jun 2001 17:35:50 -0400
Date: Mon, 11 Jun 2001 23:35:30 +0200
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tlan@stud.ntnu.no, linux-kernel@vger.kernel.org
Subject: Re: BCM5700, 1000 Mbps driver
Message-ID: <20010611233530.B10927@flodhest.stud.ntnu.no>
Reply-To: tlan@stud.ntnu.no
In-Reply-To: <20010611230603.A10927@flodhest.stud.ntnu.no> <E159Z1v-0000OH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E159Z1v-0000OH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jun 11, 2001 at 10:15:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> > * Are there anyone testing/maintaing this driver, trying to get it into the
> >   standard kernel source?
> Not right now that I know of. Nobody who read the source code did anything
> more constructive than run to throw up.

Are there any places (besides other drivers in the kernel) to look for
documents on how to write module-drivers/in-kernel drivers? 

> > * If not, would it be rude for me to make it work with the latest kernels,
> >   and then submitt it? (I won't take credit for anything I haven't done, but
> >   since I haven't written the driver itself, I don't know what you guys think)
> It does want a lot of clean up as well but go for it. I'm sure you will get
> plenty of comments on what needs cleaning up

Should I start by giving people a link to the source code? ;)  We need this
driver by the end of this summer, so I thought that making something that
could go in the std. kernel-tree was the best way of doing things. That way
we don't have to patch stuff each time either.

-- 
-Thomas
