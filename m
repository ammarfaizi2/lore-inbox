Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270474AbTGSCcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 22:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270475AbTGSCcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 22:32:16 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:50911 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP id S270474AbTGSCcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 22:32:12 -0400
Date: Sat, 19 Jul 2003 12:47:31 +1000
From: Michael Still <mikal@stillhq.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docbook: Added support for generating man files
In-Reply-To: <20030719004833.A3174@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.44.0307191237540.1829-100000@diskbox.stillhq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003, Andries Brouwer wrote:

> Please put all legalities in comments - behind .\" we do not have to read
> them, but they are there if anyone cares.

Ok. After having done some more poking, I can't see a way of doing this 
with docbook2man -- there doesn't appear to be any way of emitting 
comments. There strike me as two options here: write a script to convert 
SGML to man pages, or perhaps just insert a single sentence into the 
"About this Document" section which explains where to look for copyright 
information.

Any thoughts?

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | Stage 1: Steal underpants
http://www.stillhq.com            | Stage 2: ????
UTC + 10                          | Stage 3: Profit

