Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbWBYNFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWBYNFV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWBYNFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:05:21 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:22412 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932700AbWBYNFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:05:20 -0500
Date: Sat, 25 Feb 2006 14:05:19 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Message-ID: <20060225130519.GC8698@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk
References: <20060214152218.GI10701@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org> <200602250527.03493.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602250527.03493.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.211.213
Subject: Re: Status of X86_P4_CLOCKMOD?
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006, Andi Kleen wrote:
> On Saturday 25 February 2006 02:57, Johannes Stezenbach wrote:
> > P4 clockmod certainly sucks compared to Speedstep,
> > but IMHO it is still potentially useful for the average
> > desktop PC user (at least those many who let their PCs
> > run 24/7, but 90% idle and unused).
> 
> I don't think so no. The latencies make it unusable.

I tried to explain that I think one can use it in a way
so the latencies are not a big issue. One must
just accept that it needs different policy than
Speedstep etc.


Johannes
