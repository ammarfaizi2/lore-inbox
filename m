Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSBIRIk>; Sat, 9 Feb 2002 12:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289042AbSBIRIU>; Sat, 9 Feb 2002 12:08:20 -0500
Received: from B539c.pppool.de ([213.7.83.156]:32269 "HELO Nicole.fhm.edu")
	by vger.kernel.org with SMTP id <S289036AbSBIRIK>;
	Sat, 9 Feb 2002 12:08:10 -0500
Subject: Re: Performance of Ingo's O(1) scheduler on NUMA-Q
From: Daniel Egger <degger@fhm.edu>
To: mingo@elte.hu
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202080021520.7544-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0202080021520.7544-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 08 Feb 2002 16:15:56 +0100
Message-Id: <1013181364.31423.9.camel@sonja>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2002-02-08 um 00.23 schrieb Ingo Molnar:

> > Measuring kernel compile times on a 16 way NUMA-Q, adding Ingo's
> > scheduler patch takes kernel compiles down from 47 seconds to 31
> > seconds .... pretty impressive benefit.
 
> cool! By the way, could you try a test-compile with a 'big' .config file?

I'd assume that a 16way machine still taking 31s to compile the kernel
is already having a 'big' config file. 
 
-- 
Servus,
       Daniel

