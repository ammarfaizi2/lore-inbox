Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277234AbRJDV2O>; Thu, 4 Oct 2001 17:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277235AbRJDV2E>; Thu, 4 Oct 2001 17:28:04 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:61870 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277234AbRJDV1w>;
	Thu, 4 Oct 2001 17:27:52 -0400
Date: Thu, 04 Oct 2001 22:28:17 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: mingo@elte.hu, jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <302737894.1002234496@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.33.0110031528370.6272-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0110031528370.6272-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, 03 October, 2001 4:51 PM +0200 Ingo Molnar <mingo@elte.hu> 
wrote:

> your refusal to accept this problem as an existing and real problem is
> really puzzling me.

In at least one environment known to me (router), I'd rather it
kept accepting packets, and f/w'ing them, and didn't switch VTs etc.
By dropping down performance, you've made the DoS attack even
more successful than it would otherwise have been (the kiddie
looks at effect on the host at the end).

--
Alex Bligh
