Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262833AbRE0R0l>; Sun, 27 May 2001 13:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262832AbRE0R0a>; Sun, 27 May 2001 13:26:30 -0400
Received: from web13404.mail.yahoo.com ([216.136.175.62]:64785 "HELO
	web13404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262833AbRE0R0V>; Sun, 27 May 2001 13:26:21 -0400
Message-ID: <20010527172620.78121.qmail@web13404.mail.yahoo.com>
Date: Sun, 27 May 2001 19:26:20 +0200 (CEST)
From: =?iso-8859-1?q?Cesar=20Da=20Silva?= <thunderlight1@yahoo.com>
Reply-To: cesar.da.silva@cyberdude.com
Subject: Re: Please help me fill in the blanks.
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: kernellist <linux-kernel@vger.kernel.org>
In-Reply-To: <20010527202119.I11981@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 --- Ville Herva <vherva@mail.niksula.cs.hut.fi>
skrev: > > > * Dynamic Memory Resilience
> > 
> > RAM fault tolerance?  There was a patch a long
> time ago which detected
> > bad ram, and would mark those memory clusters as
> unuseable at boot. 
> > However that is clearly not dynamic.
> 
> If you are referring to Badram patch by Rick van
> Rein
> (http://rick.vanrein.org/linux/badram/), it doesn't
> detect the bad ram,
> memtest86 does that part (and does it well) -- you
> enter then enter the
> badram clusters as boot param. But I have to say
> badram patch works
> marvellously (thanks, Rick.) Shame it didn't find
> its way to standard
> kernel.

Hi Ville, and thanks for the great link and the
information. 

Regards,
Cesar da Silva

_____________________________________________________
Do You Yahoo!?
Ditt_namn@yahoo.se - skaffa en gratis mailadress på http://mail.yahoo.se
