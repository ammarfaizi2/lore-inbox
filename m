Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277013AbRJHRhK>; Mon, 8 Oct 2001 13:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277016AbRJHRhA>; Mon, 8 Oct 2001 13:37:00 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:29040 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S277013AbRJHRgs>; Mon, 8 Oct 2001 13:36:48 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: Larry McVoy <lm@bitmover.com>
Date: Mon, 8 Oct 2001 19:37:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [OT] testing internet performance, esp latency/drops?
CC: linux-kernel@vger.kernel.org
Message-ID: <3BC20071.5766.15AB102@localhost>
In-Reply-To: <20011008090203.L26223@work.bitmover.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   DNS maybe? What is your DNS servers topology? Are you using 
any caching DNS server? I've seen that happen in a company that 
was using an external DNS server from their isp, and in times of 
extreme internet link usage the problem would appear. Heck, even 
their sql queries would block for around 60 seconds in the 
Windows machines they used. It must have left lots of SAP 
consultants scratching their heads. :)


Pedro

On 8 Oct 2001, at 9:02, Larry McVoy wrote:


> However, web browsing sucks.  On about 80% of all links, there is a noticable
> hesitation, between 1-15 seconds, as it looks up the name and as it fetches
> the first page.  After that point, that site will appear to be OK.
> 

