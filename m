Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280843AbRKYMao>; Sun, 25 Nov 2001 07:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280871AbRKYMae>; Sun, 25 Nov 2001 07:30:34 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44807 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280843AbRKYMaZ>; Sun, 25 Nov 2001 07:30:25 -0500
Date: Sun, 25 Nov 2001 13:30:20 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011125133020.C1811@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <Pine.LNX.4.33L.0111241138070.4079-100000@imladris.surriel.com> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2001, Florian Weimer wrote:

> > However, if it's really true that DTLA drives and their successor
> > corrupt blocks (generate bad blocks) on power loss during block writes,
> > these drives are crap.
> 
> They do, even IBM admits that (on
> 
>         http://www.cooling-solutions.de/dtla-faq
> 
> you find a quote from IBM confirming this).  IBM says it's okay, you
> have to expect this to happen.  So much for their expertise in making
> hard disks.  This makes me feel rather dizzy (lots of IBM drives in
> use).

Well, claiming the OS to cause hard errors? Design fault.
Claiming DC loss to cause hard errors? Design fault.

IBM would really better shed some real light on this issue, and if they
spoiled their firmware (heck, there ARE firmware updates for OEM disks
of the 75GXP series) or electronics, they'd better admit that so as to
reinstore the trust people had before DTLA drives were sold.

FUD works its way, so personally, I'm not buying IBM drives until this
issue is FULLY resolved, so I presume, I won't buy any DTLA or and
IC35Lxx drives of the current series. This is not a recommendation, just
what I'm doing.
