Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUCLMTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 07:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUCLMTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 07:19:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27529 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262063AbUCLMTu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 07:19:50 -0500
Date: Fri, 12 Mar 2004 07:21:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Johns <cbjohns@mn.rr.com>
cc: Chip Salzenberg <chip@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
In-Reply-To: <BCE0CC77-73C7-11D8-BAF8-000A958E2366@mn.rr.com>
Message-ID: <Pine.LNX.4.53.0403120714410.4380@chaos>
References: <E1B1TIJ-0007Tm-Jn@tytlal> <BCE0CC77-73C7-11D8-BAF8-000A958E2366@mn.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Chris Johns wrote:

> Just to throw a little more gas on this particular fire (or maybe
> some water, depending on your point of view), when I worked for a while
> at the Evil Empire, the "const == variable" comparison was mandatory in
> the group I worked in. Odd to look at initially, I'll admit, but it
> still caught
> several potential bugs. One other thing that was mandatory was to
> set to NULL any pointer to memory area that was freed immediately after
> freeing it. Again, a good idea, although not a coding style issue.
>
> Chris
>

Well I'll take it as being proof that forcing a particular style
doesn't help make bug-free code since it didn't help Microsoft.

I'll bet that Microsoft has more bugs per KLOC than any other
software, ever. It is a formidable challenge to make software
that will beat it in that area. You really need to try. You
need to be cunning enough to get it through the compile-stage.
It's an art.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


