Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263797AbRFNSW7>; Thu, 14 Jun 2001 14:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263854AbRFNSWr>; Thu, 14 Jun 2001 14:22:47 -0400
Received: from dc-mx01.cluster0.hsacorp.net ([209.225.8.11]:46326 "EHLO
	dc-mx01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S263863AbRFNSWm>; Thu, 14 Jun 2001 14:22:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Cory Watson <gphat@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: Re: more on VIA 686B (trials)
Date: Thu, 14 Jun 2001 13:29:44 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15AbZW-00054e-00@the-village.bc.nu>
In-Reply-To: <E15AbZW-00054e-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01061413294401.06452@achmed>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 01:10 pm, Alan Cox wrote:
> And praying it doesnt go wrong on you - has it not occurred to you that the
> extremely high throughput copies that the mmx copy we use causes will
> occasionally happen by chance and get you anyway ?

Yeah, it's occurred to me, but it's yet to happen.  I fought with the thing 
for 48 hours, and after settling on a K6 kernel w/'Enhanced' enabled, I've 
not had a single problem.  I suppose it's possible that I've not seen the 
problem, but I've put this box through it's paces many times over since I 
settled.  I gave it another go with 2.4.6-pre3 this morning, hoping something 
had snuck in ;)

-- 
Cory 'G' Watson
   You know what we need, Hobbes? We need an attitude. Yeah, you can't be cool
if you don't have an attitude.	  -- Calvin
