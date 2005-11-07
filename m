Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVKGNLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVKGNLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 08:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVKGNLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 08:11:06 -0500
Received: from [202.125.80.34] ([202.125.80.34]:9530 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932472AbVKGNLF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 08:11:05 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Which version of 2.6.11 is most stable
Date: Mon, 7 Nov 2005 18:38:51 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B13B2BF@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which version of 2.6.11 is most stable
Thread-Index: AcXjkZhOrF7iOkE1S/Sc9lZvQ6nMswACUzwg
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Adrian,

Thanks for the information.
Also Can you please give inputs regarding.....

I have an existing Linux 2.6.11 BSP for an AMD GX processor.
What would it take me to port the complete BSP to 2.6.12 kernel?
Can I prefer to work on 2.6.11 kernel which makes me get the system up in no time without any changes made?
I guess 2.6.11 kernel will work with just a recompilation over 2.6.11.12 kernel.

An inquisitive question about Linux kernels versioning ...
How do 2.6.(x).1 and 2.6.(x).12 kernels vary?

Regards,
Mukund Jampala


-----Original Message-----
From: Adrian Bunk [mailto:bunk@stusta.de]
Sent: Monday, November 07, 2005 5:22 PM
To: Mukund JB.
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which version of 2.6.11 is most stable


On Mon, Nov 07, 2005 at 03:38:13PM +0530, Mukund JB. wrote:
> 
> Dear All,
> 
> I am in the phase of development of a Linux BSP for 2.6.11 kernel.
> Which version of 2.6.11 kernel can be called best stable? In general where do i get this king of info?
> I serched in the www.lwn.net but i failed to get the required info.

The latest, IOW 2.6.11.12 .

But note that the 2.6.11 branch is no longer maintained since kernel 
2.6.12 was released 5 months ago, and therefore lacks e.g. current 
security fixes.

> Regards,
> Mukund Jampala

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

