Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSJEBOn>; Fri, 4 Oct 2002 21:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSJEBOn>; Fri, 4 Oct 2002 21:14:43 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:32004 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261847AbSJEBOm>; Fri, 4 Oct 2002 21:14:42 -0400
Date: Sat, 5 Oct 2002 11:20:06 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: greearb@candelatech.com, <linux-kernel@vger.kernel.org>
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
In-Reply-To: <20021004.142428.101875902.davem@redhat.com>
Message-ID: <Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Thu, 03 Oct 2002 21:19:37 -0700
> 
>    Got my two new Netgear GA302t nics today.  They seem to use the
>    tg3 driver....
>    
>    I put them into the 64/66 slots on my Tyan dual amd motherboard..
>    Running kernel 2.4.20-pre8
>    
> You reported the other week problems with two Acenic's in
> this same machine right?  The second Acenic wouldn't even probe
> properly.  And the two Acenic's were identical.
> 

FWIW, my GA302T seems fine with the kernel he originally reported 
(2.4.20-pre8).


- James
-- 
James Morris
<jmorris@intercode.com.au>


