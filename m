Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbSLKBxL>; Tue, 10 Dec 2002 20:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbSLKBxL>; Tue, 10 Dec 2002 20:53:11 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:54163
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S266958AbSLKBxJ> convert rfc822-to-8bit; Tue, 10 Dec 2002 20:53:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: scott thomason <scott@thomasons.org>
Reply-To: scott@thomasons.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Orion Poplawski <orion@cora.nwra.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops on linux 2.4.20-ac1
Date: Tue, 10 Dec 2002 20:00:54 -0600
User-Agent: KMail/1.4.3
References: <3DF6291C.3090100@cora.nwra.com> <1039554145.14175.70.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1039554145.14175.70.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212102000.54287.scott@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 December 2002 03:00 pm, Alan Cox wrote:
> Random lockups on dual athlons are a notorious problem under all
> OS's. Start by checking it passes memtest86, that will verify the
> RAM is ok - and the AMD is -very- picky about RAM.
>
> If thats ok then let me know which board you have, what is plugged
> into it and what PSU you are using.

I have two AMD MP 2000+ cpus in an ASUS A7M266-D. Even after returning 
my memory for new chips the store owner memtest86'd, my combo of cpus 
and mobo was finding the occasional error. I finally ended up 
resolving it by simply underclocking the bus about 6Mhz :( 

Next time, I'm buying ECC memory.
---scott
