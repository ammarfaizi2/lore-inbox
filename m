Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317234AbSFBXrt>; Sun, 2 Jun 2002 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317235AbSFBXrs>; Sun, 2 Jun 2002 19:47:48 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:43161 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317234AbSFBXrs>;
	Sun, 2 Jun 2002 19:47:48 -0400
Date: Mon, 3 Jun 2002 09:38:49 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
Message-ID: <20020602233849.GA9381@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522103834.B10921@bougret.hpl.hp.com> <E17Aams-0002Ue-00@the-village.bc.nu> <20020523012517.GM1001@zax> <1022697627.9255.272.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 29, 2002 at 07:40:27PM +0100, Alan Cox wrote:
> On Thu, 2002-05-23 at 02:25, David Gibson wrote:
> > The signal/noise bit is probably a red herring.  We have problems with
> > the reporting of this, but it's mostly cosmetic.  I seem to have
> > confusing and contradictory information about how to interpret the
> > values the firmware reports.
> 
> Ok the old driver gets the noise level right, the newer one got it
> wrong, the current one gets it wrong. The good news is the old one
> works, the new one didnt, the current 2.4.19pre one does...

Um, ok, now I'm a bit lost.  I'm guessing by "old driver" you mean the
pre 2.4.18 one (0.06f?) by "new driver" you mean the one in 2.4.18 and
"current driver" means the one in 2.4.19pre (0.11b) - i.e. newer than
the "new" one.  Is that right?

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
