Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbULDXzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbULDXzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbULDXzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:55:36 -0500
Received: from relay00.pair.com ([209.68.1.20]:38156 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261204AbULDXz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:55:28 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41B24E6D.4010205@cybsft.com>
Date: Sat, 04 Dec 2004 17:55:25 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <32786.192.168.1.5.1102199522.squirrel@192.168.1.5> <20041204224641.GA14850@elte.hu>
In-Reply-To: <20041204224641.GA14850@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>i have released the -V0.7.32-0 Real-Time Preemption patch, which can be
>>>downloaded from the usual place:
>>>
>>
>>I have a bug to report, it shows on both of my machines (SMP and UP)
>>now running RT-V0.7.32-2. It seems to be present also on previous RT
>>releases, and don't even know if it's upstream.
>>
>>When one usb-storage flash stick is first time unplugged:
> 
> 
> hm, doesnt seem to be directly related to -RT. Could you try the vanilla
> -rc2-mm3 kernel, does it trigger there too?
> 
> 	Ingo
> 

Gene Heskett reported a very similar problem yesterday with the subject: 
  Re:2.6.10-rc2-mm3-V0.7.31-19

kr
