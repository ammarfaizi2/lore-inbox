Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbTGOHLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbTGOHLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:11:19 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:2703 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S265976AbTGOHLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:11:11 -0400
Date: Tue, 15 Jul 2003 00:24:46 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Tupshin Harper <tupshin@tupshin.com>
cc: "Ranga Reddy M - CTD ,Chennai." <rangareddym@ctd.hcltech.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: setting year to 2094 casuing Error.
In-Reply-To: <3F13A0B7.6050103@tupshin.com>
Message-ID: <Pine.LNX.4.44.0307150024260.30663-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the 32bit epoch ends in 2038...

joelja

On Mon, 14 Jul 2003, Tupshin Harper wrote:

> Ranga Reddy M - CTD ,Chennai. wrote:
> 
> >Hi,
> >
> >Iam working on linux system with Redhat -8.0.
> >
> >I have set the system time from BIOS to 17/03/2094.After setting this
> >,booted with linux O.S. 
> >
> >Now its showing system date as year=1994.I did not get how this happend.
> >
> >Can any one tell me about this???
> >
> >Thanks in advance
> >
> >-Ranga
> >  
> >
> http://www.howstuffworks.com/question75.htm
> 
> -Tupshin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


