Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbRFGO6H>; Thu, 7 Jun 2001 10:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbRFGO55>; Thu, 7 Jun 2001 10:57:57 -0400
Received: from [194.102.102.3] ([194.102.102.3]:4 "HELO ns1.Aniela.EU.ORG")
	by vger.kernel.org with SMTP id <S262662AbRFGO5q>;
	Thu, 7 Jun 2001 10:57:46 -0400
Date: Thu, 7 Jun 2001 15:20:03 +0300 (EEST)
From: "L. K." <lk@Aniela.EU.ORG>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <3B1F51DB.54BE78CA@iph.to>
Message-ID: <Pine.LNX.4.21.0106071519120.3702-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why not make it in Celsius ? Is more easy to read it this way.



On Thu, 7 Jun 2001, Philips wrote:

> Hello All!
> 
> 	Kelvins good idea in general - it is always positive ;-)
> 
> 	0.01*K fits in 16 bits and gives reasonable range.
> 
> 	but may be something like K<<6 could be a option? (to allow use of shifts
> instead of muls/divs). It would be much more easier to extract int part.
> 
> 	just my 2 eurocents.

