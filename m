Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135874AbRDTRtF>; Fri, 20 Apr 2001 13:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135852AbRDTRsu>; Fri, 20 Apr 2001 13:48:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64779 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135808AbRDTRsP>; Fri, 20 Apr 2001 13:48:15 -0400
Date: Fri, 20 Apr 2001 10:47:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Xric Brunet <ebrunet@quatramaran.ens.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Children first in fork
In-Reply-To: <200104201013.MAA03512@quatramaran.ens.fr>
Message-ID: <Pine.LNX.4.31.0104201046550.5523-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Xric Brunet wrote:
>
> Well, I tried that, and it doesn't work.

I think you're using a buggy 2.2.x kernel. 2.4.x should do this right.
Please give it a whirl.

		Linus

