Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268105AbTCFP5h>; Thu, 6 Mar 2003 10:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268130AbTCFP5h>; Thu, 6 Mar 2003 10:57:37 -0500
Received: from mail.coastside.net ([207.213.212.6]:50134 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S268105AbTCFP5g>; Thu, 6 Mar 2003 10:57:36 -0500
Mime-Version: 1.0
Message-Id: <p05210501ba8d224a7be9@[207.213.214.37]>
In-Reply-To: <20030306061254.GA24178@citd.de>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.33.0303041434220.1438-100000@localhost.localdomain>
 <20030305205032.GD2958@atrey.karlin.mff.cuni.cz>
 <p05210507ba8c20241329@[10.2.0.101]> <20030306061254.GA24178@citd.de>
Date: Thu, 6 Mar 2003 08:07:06 -0800
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@lundell-bros.com>
Subject: Re: Linux vs Windows temperature anomaly
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:12am +0100 3/6/03, Matthias Schniedermeyer wrote:
>Hmmm. Wasn't there something with IDE and the LE-Chipset.
>
>Maybe you should try a current kernel. Don't know if this old-kernel has
>the fix.

It involved DMA, I think; I've disabled IDE DMA altogether.

My current plan is to run the tests with a more recent kernel, and to 
compare PIII MSRs between a Linux and Windows boot.
-- 
/Jonathan Lundell.
