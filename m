Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752231AbWAEVoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbWAEVoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbWAEVoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:44:10 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:53692 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S1752227AbWAEVoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:44:08 -0500
In-Reply-To: <1136494876.847.38.camel@mindpipe>
References: <20050726150837.GT3160@stusta.de> <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com> <s5hpsn8md1j.wl%tiwai@suse.de> <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de> <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr> <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe> <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <1136491503.847.0.camel@mindpipe> <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de> <1136493172.847.26.camel@mindpipe> <8D670C39-7B52-407C-8BDD-3478DB172641@dalecki.de> <1136494876.847.38.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DCE66DA9-8ACF-4218-A962-338158BE9F9D@dalecki.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Tomasz Torcz <zdzichu@irc.pl>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Thu, 5 Jan 2006 22:43:49 +0100
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-05, at 22:01, Lee Revell wrote:

> On Thu, 2006-01-05 at 21:54 +0100, Marcin Dalecki wrote:
>> On 2006-01-05, at 21:32, Lee Revell wrote:
>>
>>> On Thu, 2006-01-05 at 21:18 +0100, Marcin Dalecki wrote:
>>>> Glaring problems on average commodity hardware
>>>
>>> A good first step would be to mention which driver, ALSA version and
>>> soundcard you are using.
>>
>> I will do you this favor: NONE. Using something implies that it is
>> working.
>
> Are you going to fucking help or should I just killfile you now?

It's not about helping ALSA here it's about not throwing out the window
a system which has the advantage of actually working.
