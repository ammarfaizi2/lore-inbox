Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269793AbRHKCtK>; Fri, 10 Aug 2001 22:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270698AbRHKCtA>; Fri, 10 Aug 2001 22:49:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49668 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269793AbRHKCsr>;
	Fri, 10 Aug 2001 22:48:47 -0400
Date: Fri, 10 Aug 2001 23:48:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: David Ford <david@blue-labs.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM nuisance
In-Reply-To: <3B748AA8.4010105@blue-labs.org>
Message-ID: <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, David Ford wrote:

> Is there anything measurably useful in any -ac or -pre patches after
> 2.4.7 that helps or fixes the blasted out-of-memory-but-let's-go-fsck
> -ourselves-for-a-few-hours?

No.  The problem is that whenever I change something to
the OOM killer I get flamed.

Both by the people for whom the OOM killer kicks in too
early and by the people for whom the OOM killer now doesn't
kick in.

I haven't got the faintest idea how to come up with an OOM
killer which does the right thing for everybody.

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

