Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTAERev>; Sun, 5 Jan 2003 12:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTAERev>; Sun, 5 Jan 2003 12:34:51 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:40127 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S264920AbTAERer>;
	Sun, 5 Jan 2003 12:34:47 -0500
Subject: Re: [2.5.54 - Oops] CPUFreq [Was: Re: [2.5.54] OOPS: unable to
	handle kernel paging request]
From: Steven Barnhart <sbarn03@softhome.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, rol@as2917.net
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Jan 2003 12:43:10 -0500
Message-Id: <1041788597.1136.6.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Jan 2003 11:47:01 +0000, Steven Barnhart wrote:

> On Sun, 2003-01-05 at 05:43, Paul Rolland wrote:
>> Hello,
>> 
>> Good news !
>> Using the patch : 
>> http://www.brodo.de/cpufreq/cpufreq-2.5.54-p4-1
>> it is now booting fine !
> 
> Excellent!! I will apply immediately. This is great...wonder why it
> hasn't been applied yet.
> 
> PS: Andrew: This is the serial console problem, if the patch works for
> me this should fix the problem thank god.

Obivously I spoke to soon...this doesn't fix my problem (maybe because I
don't have a p4 and cpufreq ISN'T enabled). Instead it floods my screen
with the oops now instead of staying their but from hard looking at
it..it's the exact same thing..what an annoying bug!

PS: Paul I've attached my config, any chance you could do a full serial
output on it? Hopefully that would reproduce the problem and shed some
light on it.
-- 
Steven
sbarn03@softhome.net
GnuPG Fingerprint: 9357 F403 B0A1 E18D 86D5  2230 BB92 6D64 D516 0A94

