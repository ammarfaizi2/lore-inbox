Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132934AbRDUVYy>; Sat, 21 Apr 2001 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132935AbRDUVYo>; Sat, 21 Apr 2001 17:24:44 -0400
Received: from www.teaparty.net ([216.235.253.180]:38927 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S132934AbRDUVY2>;
	Sat, 21 Apr 2001 17:24:28 -0400
Date: Sat, 21 Apr 2001 22:24:25 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Meelis Roos <mroos@linux.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: XFree4/gdm problems with 2.4.4-pre5
In-Reply-To: <Pine.GSO.4.32.0104212250410.29571-100000@romulus.cs.ut.ee>
Message-ID: <Pine.LNX.4.10.10104212217530.24186-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Meelis Roos wrote:

> The latest XFree4 (4.0.99.33 current cvs snapshot) and gdm
> 2.0-0.beta4-helix12 have problems with kernel 2.4.4-pre5. gdm has been
> the same version for long time, kerne and XFree have changed almost
> together. After logging the user out, no new gdm login appears. Tracing
> then is hard because ptraced x server runs very slowly. It may be either
> XFree or kernel.

Actually, I have seen this symptom [albeit intermittently: may be a
different cause] w. kernel 2.2.18/Xfree86-3 2.4.3/Xfree86-4 - gdm doesn't
say much, except to log one message long the lines of 'client auth
rejected' or 'connection rejected' or something like that. Haven't been
able to pin it down, except that when it happens once, it seems to happen
slightly more often for a while, and then the problem unpredictably goes
away after/for a while, sometimes for an extended period of time. [weeks
at a time, sometimes]. So it may not be possible to rule out gdm. [I'm
using the same version, but the problem occurred w. the previous version
too]

-- 
"I don't want to go to the movies to be horrified and depressed."
"No, I suppose you've got real life to do that."

