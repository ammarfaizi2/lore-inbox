Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314645AbSEPJ7x>; Thu, 16 May 2002 05:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSEPJ7w>; Thu, 16 May 2002 05:59:52 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:21932
	"EHLO awak") by vger.kernel.org with ESMTP id <S314645AbSEPJ7w> convert rfc822-to-8bit;
	Thu, 16 May 2002 05:59:52 -0400
Subject: Re: No Network after Compiling,2.4.19-pre8 under Debian Woody(Long
	Message)
From: Xavier Bestel <xavier.bestel@free.fr>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200205160919.g4G9J0Y16751@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 May 2002 11:59:08 +0200
Message-Id: <1021543152.17761.154.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 16/05/2002 à 16:21, Denis Vlasenko a écrit :
> On 16 May 2002 07:05, Xavier Bestel wrote:
> > Le jeu 16/05/2002 ? 13:20, Denis Vlasenko a ?crit :
> > > On 15 May 2002 14:38, Xavier Bestel wrote:
> > > > Yes, it works at 10Mbit. But the driver doesn't do speed negociation,
> > > > it doesn't even see the MII registers. However I think RTL8139 cards
> > > > have MII registers. I quickly looked at the source but didn't see
> > > > anything special.
> > >
> > > Becker's diag utils say there is *no* MII in RTL8139, just something
> > > vaguely resembling that. I have trouble persuading 8139 to work in
> > > 100mbit fdx, it insists on half duplex. :-(
> >
> > How do you do this ? Mine only accepts 10Mbits ...
> > I tried with mii-diad and with rtl8139-diag.
> 
> Tried too, rtl8139-diag set my nic to 10mbit and I could not boot
> with NFS root anymore. 8-]. Brought DOS-based conf utility and
> used it.

I'll have a hard time using a dos util on my machines (linux-only, not
even a floppy drive). Do you know where I can find these utils ?

	Xav

