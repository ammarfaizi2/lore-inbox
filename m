Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbUCOKMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 05:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUCOKMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 05:12:35 -0500
Received: from ep09.kernel.pl ([212.87.11.162]:53 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id S262505AbUCOKMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 05:12:34 -0500
From: Witold Krecicki <adasi@kernel.pl>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: snd-powermac volume setting broken?
Date: Mon, 15 Mar 2004 11:12:21 +0100
User-Agent: KMail/1.6.1
References: <200403130015.17674.adasi@kernel.pl> <s5hwu5miftr.wl@alsa2.suse.de>
In-Reply-To: <s5hwu5miftr.wl@alsa2.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403151112.21773.adasi@kernel.pl>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia poniedzia³ek 15 marzec 2004 11:07, napisa³e¶:
> At Sat, 13 Mar 2004 00:15:17 +0100,
>
> Witold Krecicki wrote:
> > When I use alsa snd-powermac driver, the lowest volume setting (but
> > without muting) is at about half of full volume, it's impossible to get
> > any volume level between mute and vol=0. Is that a bug or a feature?
>
> not a bug - the chip doesn't support the level below vol=0 and it's
> not totally silent.
but it's not like 'not totally silent' but 'pretty loud'. On OSX volume scale 
is just fine.
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net

