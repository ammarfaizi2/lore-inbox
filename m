Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135727AbRAGIBu>; Sun, 7 Jan 2001 03:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135845AbRAGIBb>; Sun, 7 Jan 2001 03:01:31 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:56034 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S135727AbRAGIBW>; Sun, 7 Jan 2001 03:01:22 -0500
Date: Sun, 7 Jan 2001 09:01:48 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Ulrich Drepper <drepper@cygnus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <m3k887bxsf.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.30.0101070858400.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2001, Ulrich Drepper wrote:

> This is wrong.  You cannot execute libc.so.5.  This only works with
> glibc.

I already thought of something like that (I was not able to test it...).
Can you tell me a reliable way to get the version other than just looking
for the version appended to the file name?
Or is the file name scheme reliable (/lib/libc.so.5.x.y)?

Regards,
 Matthias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
