Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUCVRMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUCVRMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:12:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48258 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262136AbUCVRMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:12:12 -0500
Date: Mon, 22 Mar 2004 12:14:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Tigran Aivazian <tigran@veritas.com>,
       David Schwartz <davids@webmaster.com>,
       Justin Piszcz <jpiszcz@hotmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Kernel Microcode Question
In-Reply-To: <405F19A3.20001@techsource.com>
Message-ID: <Pine.LNX.4.53.0403221201520.19756@chaos>
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>
 <405F0B8D.8040408@techsource.com> <Pine.LNX.4.53.0403221057400.17797@chaos>
 <405F19A3.20001@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Timothy Miller wrote:

>
>
> Richard B. Johnson wrote:
>
> >
> > ALL instructions are performed by the microcode.
>
> The Z80 had no microcode.  It was completely hard-wired.
>

Who was talking about the Z80? The WCS was added to the
Pentium line after the Patent issues were resolved.
Search on "writable control store" to see the many papers
and developments.

> As I understand it, it's pretty much an ancient idea to do "everything"
> by microcode.  Only certain very complex instructions are done by microcode.
>

One of the "latest and greatest" such machines was made by Transmeta
(a.k.a. Linus` home when he first came to the US. The Crusoe, etc.,
could emulate just about anything because its microcode was deliberately
replaceable with even microcode that was architecturally different.

> On the other hand, as I said before, it's not unreasonable for lookup
> tables to be involved in instruction decoding.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


