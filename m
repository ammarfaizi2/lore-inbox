Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUIOXAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUIOXAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUIOXAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:00:42 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:39387 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267766AbUIOXAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:00:04 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Troy McFerrron <hotdogday@gmail.com>
Date: Thu, 16 Sep 2004 08:59:52 +1000
Cc: linux-kernel@vger.kernel.org, dsw@gelato.unsw.edu.au
Subject: Re: 2.6.9-rc2 and Hyperthreading. (SMT)
Message-ID: <20040915225952.GD5556@cse.unsw.EDU.AU>
Mail-Followup-To: Troy McFerrron <hotdogday@gmail.com>,
	linux-kernel@vger.kernel.org, dsw@gelato.unsw.edu.au
References: <7798951e04091317273b1bed29@mail.gmail.com> <41465244.9010603@yahoo.com.au> <7798951e040913212154d3b3f9@mail.gmail.com> <7798951e04091322402fe830ff@mail.gmail.com> <7798951e040913224462ea2243@mail.gmail.com> <20040915011114.GA3195@cse.unsw.EDU.AU> <7798951e04091423096a17adcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7798951e04091423096a17adcc@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Troy

On Wed, 15 Sep 2004, Troy McFerrron wrote:

> On Wed, 15 Sep 2004 11:11:14 +1000, Darren Williams
> <dsw@gelato.unsw.edu.au> wrote:
> > On Tue, 14 Sep 2004, hotdog day wrote:
> > 
> > > Does anyone have any other suggestions on this issue? I know others
> > > who are experincing the same thing.
> > >
> 
> Darren, could you send me your kernel .config so I can do a diff and
> see what you might be doing differently?
Over night I compiled and tested with X on results are OK
Quick mount, unmount of cd drive OK
LTP tests OK

Config file and results at:
http://quasar.cse.unsw.edu.au/~dsw/public-files/x86/with-X/

Darren

> 
> -- 
> Troy McFerron
> Kernel Ricer and Linux Hobbyist Extrodinaire.
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
