Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWGAWw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWGAWw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGAWw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:52:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20952 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751371AbWGAWwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:52:55 -0400
Date: Sun, 2 Jul 2006 00:51:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       Olivier Galibert <galibert@pobox.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
In-Reply-To: <1151762066.11897.5.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0607020051280.14511@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de>  <44A54D8E.3000002@superbug.co.uk>
 <20060630163114.GA12874@dspnet.fr.eu.org>  <1151702966.32444.57.camel@mindpipe>
  <1151703286.11434.61.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0607011048360.25773@yvahk01.tjqt.qr> <1151762066.11897.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I cannot really use my onboard snd-intel8x0 because it lacks volume
>> control on Master/PCM (= blows every headphone away), etc.
>> 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
>> AC'97 Sound Controller (rev a0)
>
>ALSA should provide a master volume, it's only the kernel OSS emulation
>that cannot control the volume on such devices.  If ALSA does not give
>you volume controls, please file a bug report.
>
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2250


Jan Engelhardt
-- 
