Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTDQBEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbTDQBEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:04:31 -0400
Received: from windsormachine.com ([206.48.122.28]:1290 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S262621AbTDQBEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:04:30 -0400
Date: Wed, 16 Apr 2003 21:16:23 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
In-Reply-To: <200304162205.XAA15178@mauve.demon.co.uk>
Message-ID: <Pine.LNX.4.33.0304162115030.13548-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Apr 2003 root@mauve.demon.co.uk wrote:

> This has a little basis in fact.
>
> "Double sided SIMMs" can have higher capacitances on the data lines, as there
> are more pins connected to the socket.
> This means more loading, especially at high speed.
>
> Add in marginal designs, and it can make a difference.

As well, these usually use two banks of memory.

I have a pair of crucial 256 meg sticks in my home pc, one is single sided
and one is double sided.  when I decide that 512 meg isn't enough, I have
to make sure I get a stick that uses only one bank of ram, as my ASUS
p4B533-e shares DIMM2 and DIMM3's banks.  You can only have single sided
dimms in it if you want to use both at once.

Mike

