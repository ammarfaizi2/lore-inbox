Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbREROIP>; Fri, 18 May 2001 10:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbREROIF>; Fri, 18 May 2001 10:08:05 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:46609 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S262326AbREROHv>; Fri, 18 May 2001 10:07:51 -0400
Message-Id: <200105181407.f4IE6cU10011@aslan.scsiguy.com>
To: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: New AIC7xxx driver - Berkeley DB1 to DB3 
In-Reply-To: Your message of "Fri, 18 May 2001 08:59:22 +0200."
             <Pine.WNT.4.31.0105180857350.65-100000@pc209.sinfopragma.it> 
Date: Fri, 18 May 2001 08:06:38 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Can someone verify if it's legal to change the include/link in the
>assembler for AIC7xxx ? DB 1.85 has header clash with DB 3 (db.h).

If you upgrade to the latest driver from here:

http://people.FreeBSD.org/~gibbs/linux/

you won't have to deal with the aicasm build.

--
Justin
