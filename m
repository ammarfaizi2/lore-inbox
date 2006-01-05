Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752097AbWAEHON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbWAEHON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbWAEHON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:14:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3464 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752091AbWAEHOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:14:11 -0500
Date: Thu, 5 Jan 2006 08:13:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Bortas <bortas@gmail.com>
cc: Stefan Smietanowski <stesmi@stesmi.com>,
       =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <7e5f60720601041903s3462bf9bib9ada16fe70ef988@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601050812040.10161@yvahk01.tjqt.qr>
References: <200601031522.06898.s0348365@sms.ed.ac.uk>  <s5hvex1m472.wl%tiwai@suse.de>
  <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> 
 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> 
 <20060103231009.GI3831@stusta.de>  <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
  <43BB16C0.3080308@stesmi.com>  <Pine.BSO.4.63.0601040146540.29027@rudy.mif.pg.gda.pl>
  <43BB9A0B.3010209@stesmi.com> <7e5f60720601041903s3462bf9bib9ada16fe70ef988@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>No. Everything on Solaris uses the Solaris native sound API except for
>possibly quick-hack ports of applications from Linux. Doing anything
>else would as you say be insane and break things like device
>redirection on Sunrays.
>
Device redirection is just "writing to a different /dev node" - on
Solaris and Linux. IIRC, the API is the same.



Jan Engelhardt
-- 
