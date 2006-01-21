Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWAUI7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWAUI7y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWAUI7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:59:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3806 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751190AbWAUI7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:59:54 -0500
Date: Sat, 21 Jan 2006 09:58:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Zubaj <pzad@pobox.sk>
cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       perex@suse.cz
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
 approach
In-Reply-To: <200601201844.29873.pzad@pobox.sk>
Message-ID: <Pine.LNX.4.61.0601210958010.21704@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de> <s5hmzhr7xsr.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601201729370.10065@yvahk01.tjqt.qr> <200601201844.29873.pzad@pobox.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ah, so http://alphagate.hopto.org/quad_dsp/ which I had created
>> is The Right Thing?
>
>This will work for your card, but not for emu10k1.

Does emu10k1 provide no adsp, how does it work?


Jan Engelhardt
-- 
