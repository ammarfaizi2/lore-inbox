Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319449AbSILVVy>; Thu, 12 Sep 2002 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319470AbSILVVy>; Thu, 12 Sep 2002 17:21:54 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:22432 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S319449AbSILVVZ> convert rfc822-to-8bit; Thu, 12 Sep 2002 17:21:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Thunder from the hill <thunder@lightweight.ods.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Killing/balancing processes when overcommited
Date: Thu, 12 Sep 2002 16:22:10 -0500
User-Agent: KMail/1.4.1
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Jim Sibley <jlsibley@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, <riel@conectiva.com.br>
References: <Pine.LNX.4.44.0209121514330.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209121514330.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209121622.10188.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 04:15 pm, Thunder from the hill wrote:
> Hi,
>
> On 12 Sep 2002, Alan Cox wrote:
> > Because I've run real world large systems before. Ulimit is at best a
> > handy little toy for stopping web server accidents.
>
> Only if you assume that a bunch of users tries very hard to use up all the
> resources...
>
> 			Thunder

It only takes one.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
