Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268413AbTCFVtJ>; Thu, 6 Mar 2003 16:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268414AbTCFVtJ>; Thu, 6 Mar 2003 16:49:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26382 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268413AbTCFVtI>; Thu, 6 Mar 2003 16:49:08 -0500
Date: Thu, 6 Mar 2003 13:57:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Hayes <mike@aiinc.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix breakage caused by spelling 'fix'
In-Reply-To: <200303062141.h26LfZK19533@aiinc.aiinc.ca>
Message-ID: <Pine.LNX.4.44.0303061356030.8521-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Michael Hayes wrote:
>
> This fixes a spelling "fix" that resulted in a compile error.
> 
> With apologies to Russell King.

Ugh, please make things like this just write out the full non-contracted 
thing. Ie "cannot" is a perfectly fine word, we don't need to force 
spelling errors.

		Linus

