Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317162AbSFFTB5>; Thu, 6 Jun 2002 15:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSFFTB4>; Thu, 6 Jun 2002 15:01:56 -0400
Received: from smtp.WPI.EDU ([130.215.24.62]:41476 "EHLO smtp.WPI.EDU")
	by vger.kernel.org with ESMTP id <S317162AbSFFTBy>;
	Thu, 6 Jun 2002 15:01:54 -0400
Date: Thu, 6 Jun 2002 15:01:51 -0400 (EDT)
From: "Brian J. Conway" <bconway@WPI.EDU>
To: Arjan Filius <iafilius@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise Ultra100 hang
In-Reply-To: <Pine.LNX.4.44.0206062043470.6451-100000@sjoerd.sjoerdnet>
Message-ID: <Pine.OSF.4.43.0206061457190.14804-100000@cpu.WPI.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Brian,
>
> Same issue here, 2.4.18 running fine with my new 160GB maxtor drive on a
> promise udma100 ide controller, 2.4.19-pre9 hangs on partition check at
> boot time.

It occured to me that the only 2.4.18 I tried was the stock Mandrake 8.2
one, I'll go back and try a vanilla compile when I get a chance to see if
it works correctly (I will hope so, I don't know what it was patched
with).

> I saw in the incremental patches many promise related changes in
> pre8->pre9, but i havn't tested pre8 yet.
>
>
> I've inlcluded my /var/log/boot.msg (2.4.18) in case this may help to
> solve the problem.

Looks very much like mine.

<snip>

-b


