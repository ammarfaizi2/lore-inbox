Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031274AbWI1AN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031274AbWI1AN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031277AbWI1ANZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:13:25 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18111 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1031274AbWI1ANZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:13:25 -0400
Message-ID: <451B137D.9070509@zytor.com>
Date: Wed, 27 Sep 2006 17:12:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: An Ode to GPLv2 (was Re: GPLv3 Position Statement)
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609241917520.3952@g5.osdl.org> <20060925044010.GN541@1wt.eu> <1159185611.3085.26.camel@laptopd505.fenrus.org> <20060925130711.GC1517@1wt.eu>
In-Reply-To: <20060925130711.GC1517@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Mon, Sep 25, 2006 at 02:00:05PM +0200, Arjan van de Ven wrote:
>> On Mon, 2006-09-25 at 06:40 +0200, Willy Tarreau wrote:
>>> do a few months back. After all the fuss about binary-only modules
>>> incompatibility with GPLv2, I wanted to change the license of haproxy
>>> to explicitly permit external binary-only code to be linked with it. 
>> LGPL is then a logical and commonly accepted choice for a license
> 
> Not exactly, because I don't want people to include interesting parts
> of my code into their binary-only programs. I just want to allow
> people to link binary-only modules with my program. However, programs
> that are already GPLv2 are welcome to steal part of my code.
> 

That sounds like the LGPL to me...

	-hpa
