Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130272AbRCBB6I>; Thu, 1 Mar 2001 20:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130276AbRCBB57>; Thu, 1 Mar 2001 20:57:59 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:63495 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S130272AbRCBB5q>;
	Thu, 1 Mar 2001 20:57:46 -0500
Date: Thu, 1 Mar 2001 22:57:39 -0300
From: Rogerio Brito <rbrito@iname.com>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: linux-kernel@vger.kernel.org
Subject: [Newbie] Re: Problem creating filesystem
Message-ID: <20010301225739.A674@iname.com>
Mail-Followup-To: Jeremy Jackson <jerj@coplanar.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <11dd01c0a04e$98b92e60$f40237d1@MIACFERNANDEZ> <3A9B24BE.69777690@coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A9B24BE.69777690@coplanar.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26 2001, Jeremy Jackson wrote:
> Carlos Fernandez Sanz wrote:
> > The IDE controller is
> >   Bus  0, device  17, function  0:
> >     Unknown mass storage controller: Promise Technology Unknown device (rev
> > 2).
> >       Vendor id=105a. Device id=d30.
> >       Medium devsel.  IRQ 10.  Master Capable.  Latency=32.
> 
> Unrelated to disk "problem", you might want to set your PCI latency timer in
> BIOS to 64 or more.

	Ok, I understand that this is probably off-topic and way too
	basic, but what exactly would this do, in layman terms? Would
	the latency being set to 32 result in any potential data
	corruption?  BTW, to set this quantity, one should use setpci,
	right?


	Thanks for any help, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
