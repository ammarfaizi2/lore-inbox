Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135786AbREBTuy>; Wed, 2 May 2001 15:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135792AbREBTuo>; Wed, 2 May 2001 15:50:44 -0400
Received: from 3jane.ashpool.org ([195.24.172.2]:34061 "EHLO 3jane.ashpool.org")
	by vger.kernel.org with ESMTP id <S135786AbREBTu3>;
	Wed, 2 May 2001 15:50:29 -0400
Date: Wed, 2 May 2001 21:56:20 +0200 (CEST)
From: poptix <poptix@poptix.net>
X-X-Sender: <poptix@3jane.ashpool.org>
To: Cliff Albert <cliff@oisec.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.4.4, 2.4.4-ac1, 2.4.4-ac2, neighbour discovery bug
 (ipv6)
In-Reply-To: <20010501154437.A23200@oisec.net>
Message-ID: <Pine.LNX.4.33.0105022155090.444-100000@3jane.ashpool.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 May 2001, Cliff Albert wrote:

>
> When i traceroute6 my 2.4.4 box on my local lan, the 2.4.4 box panic's after about 10 seconds. The traceroute6 completes on the other box.
>
> 2.4.3-ac14 doesn't experience these problems. Only 2.4.4 (with or without ac{1,2}) panics
>
> ---- traceroute6 output ----
> traceroute to neve.oisec.net (3ffe:8114:2000:0:250:bfff:fe21:629a) from 3ffe:8114:2000:0:210:4bff:feb3:1fb4, 30 hops max, 16 byte packets
>  1  neve.oisec.net (3ffe:8114:2000:0:250:bfff:fe21:629a)  0.583 ms  0.278 ms  0.233 ms
>
>
[snip]

I am unable to reproduce this, either locally or remotely, I am also using
the 2.4.4 kernel, do you have any more information on this, and is it
possible to reproduce every time?



			Matthew S. Hallacy

