Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136129AbRA1BBI>; Sat, 27 Jan 2001 20:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136105AbRA1BA6>; Sat, 27 Jan 2001 20:00:58 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:38304 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S136073AbRA1BAr>; Sat, 27 Jan 2001 20:00:47 -0500
Date: Sat, 27 Jan 2001 16:58:15 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Frank v Waveren <fvw@var.cx>
cc: David Wagner <daw@cs.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <20010127191809.A3727@var.cx>
Message-ID: <Pine.LNX.4.31.0101271657200.2382-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Jan 2001, Frank v Waveren wrote:

> Why? Why not just zero them, and get both security and compatibility...
>

the problem is that you don't know what they mean, just zeroing them may
break things (how will the sender know that you zeroed them).

David Lang

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
