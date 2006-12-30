Return-Path: <linux-kernel-owner+w=401wt.eu-S1755184AbWL3Rrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbWL3Rrq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbWL3Rrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 12:47:46 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:36597 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbWL3Rrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 12:47:45 -0500
Date: Sat, 30 Dec 2006 19:47:47 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: =?iso-8859-1?Q?Beno=EEt?= Rouits <brouits@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       PeiSen Hou <pshou@realtek.com.tw>
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
Message-ID: <20061230174747.GB4637@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1167411986.6309.80.camel@chimay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167411986.6309.80.camel@chimay>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Dec 2006 17:49:45.0062 (UTC) FILETIME=[E423B860:01C72C3A]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--8.388000-4.000000-31
X-Spam: [F=0.1589067726; S=0.158(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Since 2.6.20-rc1 (tested both -rc1 and rc2), system notification sounds under
> > > KDE, and sound in games (e.g. TuxPaint) no longer seem to work on my T60
> > > thinkpad. Works fine under 2.6.19 though.  The strange thing is e.g. Amarok
> > > still plays music fine.
> > 
> > Tis is on Kubuntu 6.06, BTW.
> > 
> 
> Hello,
> I think your kernel is Ok with your sound card.
> The problem is from KDE.
> 
> I suggest you look at: 
> - your "KDE control center" => sound system and configure ArtsD
> - verify Amarok's preferences to see if ALSA or ArtsD are used.
> cheers.

Don't really see anything strange there.
KDE is set to ALSA. Amarok is set to autodetect.

Why would things work fine when I switch back to 2.6.19?

-- 
MST
