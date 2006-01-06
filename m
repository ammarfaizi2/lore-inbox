Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWAFClA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWAFClA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWAFClA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:41:00 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:35730 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932604AbWAFCk7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:40:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UQSq5IdST0W7C0uW9ixTUbo2Mj5JAmESZw72isHEJbWYT4ljUgmtML5YW7dvLm0OB7bEo84dmeGqjhdW/lkHYIBJmKvw9f505I/fTfNHIiAr9uGR/wW2HRVUzI9K0gT94KyK6mzRwB0HjRLmdAR23FjXH1FxPfmFygxVogy7VKM=
Date: Fri, 6 Jan 2006 03:40:26 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: rlrevell@joe-job.com, jengelh@linux01.gwdg.de, tiwai@suse.de,
       jesper.juhl@gmail.com, bunk@stusta.de, zdzichu@irc.pl,
       galibert@pobox.com, s0348365@sms.ed.ac.uk, ak@suse.de, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, linux@thorsten-knabe.de, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-Id: <20060106034026.c37c1ed9.diegocg@gmail.com>
In-Reply-To: <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de>
References: <20050726150837.GT3160@stusta.de>
	<200601031522.06898.s0348365@sms.ed.ac.uk>
	<20060103160502.GB5262@irc.pl>
	<200601031629.21765.s0348365@sms.ed.ac.uk>
	<20060103170316.GA12249@dspnet.fr.eu.org>
	<s5h1wzpnjrx.wl%tiwai@suse.de>
	<20060103203732.GF5262@irc.pl>
	<s5hvex1m472.wl%tiwai@suse.de>
	<9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	<20060103215654.GH3831@stusta.de>
	<9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com>
	<s5hpsn8md1j.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
	<F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de>
	<Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
	<0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de>
	<1136486021.31583.26.camel@mindpipe>
	<E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 5 Jan 2006 21:03:27 +0100,
Marcin Dalecki <martin@dalecki.de> escribió:

> 
> On 2006-01-05, at 19:33, Lee Revell wrote:
> 
> > On Thu, 2006-01-05 at 13:44 +0100, Marcin Dalecki wrote:
> >> Second - you still didn't explain why this allows you to conclude
> >> that sound mixing should in no way be done inside the kernel.
> >
> > It works perfectly right now in userspace.
> 
> Yeah - for you maybe...


Amazing - even windows is getting sound mixing out of the kernel
in windows vista because they've learnt (the hard way) that it's
the Right Thing and linux people is trying to get it in?

