Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965294AbWFYSLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbWFYSLG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 14:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbWFYSLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 14:11:05 -0400
Received: from mail.gmx.net ([213.165.64.21]:31136 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965294AbWFYSLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 14:11:03 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2 (NULL pointer dereference)
Date: Sun, 25 Jun 2006 20:11:36 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606251825.26614.dominik.karall@gmx.net> <20060625101840.4f90da21.akpm@osdl.org>
In-Reply-To: <20060625101840.4f90da21.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606252011.36602.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 25. June 2006 19:18, Andrew Morton wrote:
> On Sun, 25 Jun 2006 18:25:26 +0200
>
> Dominik Karall <dominik.karall@gmx.net> wrote:
> > On Saturday, 24. June 2006 15:19, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
> > >.6.1 7/2.6.17-mm2/
> >
> > hi!
> >
> > I got this error with 2.6.17-mm1 too, I took a picture with my
> > mobile, hope it's readable:
> > http://stud4.tuwien.ac.at/~e0227135/kernel/060625_180209.jpg
>
> hm, that's new.  We do seem to be getting a few sysfs/kobject
> crashes in there.
>
> Do you actually have the bttv hardware present?

Yes, the bttv hardware is present. You can find my lspci output and 
the .config file which I used for that kernel at:
http://stud4.tuwien.ac.at/~e0227135/kernel/

hth,
dominik
