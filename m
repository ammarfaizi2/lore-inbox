Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVAEWSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVAEWSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVAEWSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:18:15 -0500
Received: from rly-ip04.mx.aol.com ([64.12.138.8]:4816 "EHLO
	rly-ip04.mx.aol.com") by vger.kernel.org with ESMTP id S262584AbVAEWSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:18:07 -0500
Message-ID: <41DC67EF.50105@yahoo.co.uk>
Date: Wed, 05 Jan 2005 22:19:27 +0000
From: christos gentsis <christos_gentsis@yahoo.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
CC: linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Open hardware wireless cards
References: <20050105200526.GL5159@ruslug.rutgers.edu>
In-Reply-To: <20050105200526.GL5159@ruslug.rutgers.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.52.87
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:

>On Wed, Jan 05, 2005 at 02:24:47PM -0500, Luis R. Rodriguez wrote:
><-- snip -->
>
>  
>
>>As far as support for the new chipsets goes -- sorry -- we won't be able
>>to support it as I don't think even Conexant has a final well tested
>>linux source base ready for 2.6. And even if we are given a source base
>>there is nothing we can do to get around the need for the closed-source 
>>softmac libs that it relies on. As much as I'd like to support it, I
>>don't want to get a headache to support something I cannot modify so I
>>won't be willing to support a half-opened driver as the atheros driver.
>>    
>>
>
>I'd also like to add...
>
>For those of you frustrated about our current wireless driver situation
>in open platforms --
>
>I think we probably will have this trouble with most modern hardware for a while
>(graphics cards, wireless driver, etc). A lot of has to do with patent
>infringement issues, "intellectual property" protection, and other
>business-oriented excuses.
>
>What I think we probably will have to do is just work torwards seeing if
>we can come up with our own open wireless hardware. I know there was
>a recent thread on lkml about an open video card -- anyone know where
>that ended up?
>
>If we can't come up with our own project to work on open hardware we can
>also just see if its feasible to purchase hardware companies on the
>verge of going backrupt and buy them out and release the specs/etc (a la
>blender). Can someone do the math here? I'm lazy.
>
>	Luis
>
>  
>
hello anyone

i thing that i didn't get the point... what did suppose to mean "we can 
come up with our own open wireless hardware". does it means that the 
kernel/ Linux community to design a complete hardware from scratch?

I'm don't know if there is people that would like to work in a project 
like that. if there is people that would like to do it i don't know if 
they can do it...

in case that i would had the choice then i get my wireless card, to make 
a new my one based to the design of someone that i don't know, not 
knowing if it is going to work in all cases and environments and knowing 
that i would use FPGA instead of ICs created for this functionality... i 
would not do it... i know what means designing hardware even if i don't 
have great experience in that (only some basic experience in Verilog...) 
i think that an idea like that is much closer to the opercores 
situation...(www.opencores.org)

According to my understanding, the problem with the wireless cards 
drivers and generally the drivers can be solved in two ways... first 
convincing the companies to produce the drivers or help other people 
code them.
OR
reverse engineering to the win drivers...(i think that this is harder)

i never understand way companies don't help with the drivers under 
linux.... in any way they are going to sell more products...

any way sorry for the long text and C.U. around.

Christos
 
