Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280801AbRK1WgX>; Wed, 28 Nov 2001 17:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280909AbRK1WgO>; Wed, 28 Nov 2001 17:36:14 -0500
Received: from blackhole.compendium-tech.com ([64.156.208.74]:65503 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S280801AbRK1WgG>; Wed, 28 Nov 2001 17:36:06 -0500
Date: Wed, 28 Nov 2001 14:35:08 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Alexander Viro <viro@math.psu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <3BF09E44.58D138A6@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0111281429420.23481-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Jeff Garzik wrote:

> He and davej still have a point.  Your code formatting is non-standard,
> and is difficult to read.  A document exists CodingStyle which explains
> a good style, and further -why- it is a good style.

I find the style in Doc*/CodingStyle to be hard to read as well. I code 
much like Richard does -- vertical whitespace is good. horizontal 
whitespace is good. braces have no business on the same line as an opening 
statement. The 'TAB' character should never be found within code. Little 
things like that (OK, commence flames). 

I agree with the 'whatever, it's hard to maintain 20-someodd years down 
the road' statement, but i also think that the author of code should be 
able to choose his own style; those who edit that code should conform to 
that style the author chose when he wrote it. 

anyways, enough of this, i have better things to do than get into another 
pissing contest about coding style.

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

