Return-Path: <linux-kernel-owner+w=401wt.eu-S1755048AbWL2RH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbWL2RH3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755054AbWL2RH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:07:29 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:52130 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbWL2RH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:07:28 -0500
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
From: =?ISO-8859-1?Q?Beno=EEt?= Rouits <brouits@free.fr>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       PeiSen Hou <pshou@realtek.com.tw>
In-Reply-To: <20061229071819.GB19327@mellanox.co.il>
References: <20061229062559.GB16659@mellanox.co.il>
	 <20061229071819.GB19327@mellanox.co.il>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Dec 2006 18:06:26 +0100
Message-Id: <1167411986.6309.80.camel@chimay>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I think your kernel is Ok with your sound card.
The problem is from KDE.

I suggest you look at: 
- your "KDE control center" => sound system and configure ArtsD
- verify Amarok's preferences to see if ALSA or ArtsD are used.
cheers.

Le vendredi 29 décembre 2006 à 09:18 +0200, Michael S. Tsirkin a écrit :
> > Since 2.6.20-rc1 (tested both -rc1 and rc2), system notification sounds under
> > KDE, and sound in games (e.g. TuxPaint) no longer seem to work on my T60
> > thinkpad. Works fine under 2.6.19 though.  The strange thing is e.g. Amarok
> > still plays music fine.
> 
> Tis is on Kubuntu 6.06, BTW.
> 

