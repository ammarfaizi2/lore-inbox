Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290758AbSARRZm>; Fri, 18 Jan 2002 12:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290757AbSARRZc>; Fri, 18 Jan 2002 12:25:32 -0500
Received: from lsanca1-ar27-4-63-187-072.vz.dsl.gtei.net ([4.63.187.72]:19587
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S290758AbSARRZS>; Fri, 18 Jan 2002 12:25:18 -0500
Date: Fri, 18 Jan 2002 09:25:03 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPs reading audio data from CD, ide-cd.
In-Reply-To: <Pine.LNX.4.44.0201180955520.29505-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0201180923490.18054-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Zwane Mwaikambo wrote:

> Which kernel version?

2.5.2, patched with: accessfs, i810_audio 0.20

>And could you manually run a ksymoops on the *first*
> oops you receive, avoiding rebooting if possible.

I have enabled /var/log/ksymoops and will try to recreate the problem
again today.

-- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf


