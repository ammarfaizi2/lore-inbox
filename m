Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277391AbRJEOax>; Fri, 5 Oct 2001 10:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277392AbRJEOap>; Fri, 5 Oct 2001 10:30:45 -0400
Received: from robur.slu.se ([130.238.98.12]:43530 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S277391AbRJEOa3>;
	Fri, 5 Oct 2001 10:30:29 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15293.50321.681223.620902@robur.slu.se>
Date: Fri, 5 Oct 2001 16:32:49 +0200
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, jamal <hadi@cyberus.ca>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <302417729.1002234175@[195.224.237.69]>
In-Reply-To: <15291.5314.595897.458571@robur.slu.se>
	<302417729.1002234175@[195.224.237.69]>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alex Bligh - linux-kernel writes:

 > I seem to remember jamal saying the NAPI stuff was available
 > since 2.(early). Is there a stable 2.2.20 patch?


 Hello!

 Current NAPI incarnation came first for 2.4.3 and holds ANK trademark.
 Jamal had pre-NAPI patches long before and we have been testing/profiling
 polling and flow control versions of popular network drivers in the lab and 
 on on highly loaded Internet sites for a long time. I consider the NAPI
 work to initiated by Jamal at OLS two years ago. No I don't know of any 
 usable code for 2.2.*

 Cheers.

						--ro




