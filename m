Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbSLWRVT>; Mon, 23 Dec 2002 12:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSLWRVT>; Mon, 23 Dec 2002 12:21:19 -0500
Received: from [212.18.235.100] ([212.18.235.100]:64269 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S266926AbSLWRVS>; Mon, 23 Dec 2002 12:21:18 -0500
Subject: Re: OT: Which Gigabit ethernet card?
From: Justin Cormack <justin@street-vision.com>
To: nick@snowman.net
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Sampson Fung <sampson@attglobal.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0212230949270.22216-100000@ns.snowman.net>
References: <Pine.LNX.4.21.0212230949270.22216-100000@ns.snowman.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Dec 2002 17:28:11 +0000
Message-Id: <1040664496.7156.112.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

er, no. GigE over copper autodetects crossovers, so a standard cable
will work anyway. Actually this has been backported to some 100MB
switches now (presumably use same io interfaces) so crossover cables are
fast disappearing. You can even stick a non crossover cable between a
100MB pci card and a GigE one and it will work.

On Mon, 2002-12-23 at 14:50, nick@snowman.net wrote:
> I belive this is incorrect.  A traditional ethernet crossover crosses two
> pairs, as ethernet & fast ethernet use 2 pairs.  Gigabit ethernet uses all
> 4 pairs, and would need all 4 pairs crossed I assume.
> 	Nick
> 
> On Mon, 23 Dec 2002, Roy Sigurd Karlsbakk wrote:
> 
> > yes, but be careful, as cat 5e is pretty tough when it comes to the 
> > connector specs
> > 
> > roy
> > 
> > On Saturday, December 21, 2002, at 06:28 PM, Sampson Fung wrote:
> > 
> > > Can I just use a standard Cross Over UTP cable to link up two Intel
> > > Gigabit card, just like Fast Ethernet does?
> > >
> > > Sampson Fung
> > > sampson@attglobal.net
> > >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org
> > > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jurgen Kramer
> > > Sent: Saturday, December 21, 2002 8:43 PM
> > > To: linux-kernel@vger.kernel.org
> > > Subject: Re: OT: Which Gigabit ethernet card?
> > >
> > >
> > > Thanks! I am going to try the Intel card.
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


