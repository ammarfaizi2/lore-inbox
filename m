Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWBYElf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWBYElf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWBYEle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:41:34 -0500
Received: from cantor2.suse.de ([195.135.220.15]:35000 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932670AbWBYElW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:41:22 -0500
From: Andi Kleen <ak@suse.de>
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: Status of X86_P4_CLOCKMOD?
Date: Sat, 25 Feb 2006 05:27:01 +0100
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
References: <20060214152218.GI10701@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org>
In-Reply-To: <20060225015722.GC8132@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602250527.03493.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 02:57, Johannes Stezenbach wrote:
> On Thu, Feb 23, 2006, Dave Jones wrote:
> > On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
> >  > And if the option is mostly useless, what is it good for?
> > 
> > It's sometimes useful in cases where the target CPU doesn't have any better
> > option (Speedstep/Powernow).  The big misconception is that it
> > somehow saves power & increases battery life. Not so.
> > All it does is 'not do work so often'.  The upside of this is
> > that in some situations, we generate less heat this way.
> 
> Doesn't less heat imply less power consumption?

Not in this case no.

> P4 clockmod certainly sucks compared to Speedstep,
> but IMHO it is still potentially useful for the average
> desktop PC user (at least those many who let their PCs
> run 24/7, but 90% idle and unused).

I don't think so no. The latencies make it unusable.

-Andi
 
