Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317760AbSGPGTU>; Tue, 16 Jul 2002 02:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317761AbSGPGTT>; Tue, 16 Jul 2002 02:19:19 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:44049 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S317760AbSGPGTT> convert rfc822-to-8bit; Tue, 16 Jul 2002 02:19:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: more A3D
Date: Tue, 16 Jul 2002 01:22:16 -0500
User-Agent: KMail/1.4.2
References: <0f7a31429041072DTVMAIL8@smtp.cwctv.net>
In-Reply-To: <0f7a31429041072DTVMAIL8@smtp.cwctv.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207160122.16781.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there support for A3D on ALSA?

If you're talking about Aureal Vortex2 (au8830), then no, not at 
the moment.  We're not sure if there ever will be.

As you probably know, Aureal went bankrupt and got bought out by 
competitor Creative Labs.  Creative Labs refuses to support the 
Vortex2 anymore, either via driver updates or by releasing 
developer specs on it.  I imagine Creative's goal is to force 
all Vortex2 owners to buy new soundcards and hope they buy 
SBLive cards.

Aureal did release a partially closed-source OSS driver for the 
Vortex2.  Currently some hackers at 
http://aureal.sourceforge.net/ are working on reverse 
engineering those drivers so they can rewrite completely 
open-source drivers from scratch.  So far, there's no word on 
how long they expect that to take...

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
