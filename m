Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285277AbRLNAXy>; Thu, 13 Dec 2001 19:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285279AbRLNAXo>; Thu, 13 Dec 2001 19:23:44 -0500
Received: from kullstam.ne.mediaone.net ([66.30.137.210]:52616 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S285277AbRLNAXh>; Thu, 13 Dec 2001 19:23:37 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre11 de2104X tulip driver problem
In-Reply-To: <20011213150346.A31843@Sophia.soo.com>
	<m2hequpw3a.fsf@euler.axel.nom> <3C193AD3.55AFF698@mandrakesoft.com>
Organization: none
Date: 13 Dec 2001 19:23:31 -0500
In-Reply-To: <3C193AD3.55AFF698@mandrakesoft.com>
Message-ID: <m2bsh2ps3g.fsf@euler.axel.nom>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Johan Kullstam wrote:
> > i have a DEC DE450 (based on 21041 AA chipset).  i guess, for
> > 2104[01], tulip driver has been broken since 2.4.4 (yes, that's over
> > six months of brokeness).  yes, jeff garzik knows about it.  i've
> > emailed the list and sourceforge &c.
> 
> This is a bug report for de2104x not tulip.  de2104x was created to fix
> the 2104x problems in tulip, which is getting really hairy to
> maintain.

ah ok.  sorry to crap on you.  i guess the proliferation of tulip
clones is getting pretty crazy.

i got a switch over the weekend.  my DE500 (DEC 21140AB w/o MII)
wouldn't negotiate full-duplex.  i finally just broke down and
scrapped my tulips and put in a 3com905b instead.

-- 
J o h a n  K u l l s t a m
[kullstam@mediaone.net]
