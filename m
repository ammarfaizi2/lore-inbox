Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbUKQLGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbUKQLGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUKQLFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:05:10 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:2583 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262202AbUKQLEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:04:36 -0500
Message-ID: <419B3038.3040108@tebibyte.org>
Date: Wed, 17 Nov 2004 12:04:24 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org> <419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org> <20041117060648.GA19107@logos.cnet> <20041117060852.GB19107@logos.cnet> <20041117063832.GC19107@logos.cnet>
In-Reply-To: <20041117063832.GC19107@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti escreveu:
> On Wed, Nov 17, 2004 at 04:08:52AM -0200, Marcelo Tosatti wrote:
> Just went on through the archives and indeed the spurious OOM kills started
> happening when the swap token code was added to the tree.

The LKML archives? We had been discussing this on Con Kolivas's list 
previously where we determined it was a problem in mainline so on Con's 
suggestion I signed up to LKML and discussed it here.

However, looking back through my mailbox the first report I made was 
2.6.8.1-ck3 *with the tbtc patches added*

I'm away to try 2.6.8.1 without....

Later,
Chris
