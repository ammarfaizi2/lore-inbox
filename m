Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbRFWBdN>; Fri, 22 Jun 2001 21:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265422AbRFWBdD>; Fri, 22 Jun 2001 21:33:03 -0400
Received: from james.kalifornia.com ([208.179.59.2]:38228 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265400AbRFWBct>; Fri, 22 Jun 2001 21:32:49 -0400
Message-ID: <3B33F1AC.6020603@blue-labs.org>
Date: Fri, 22 Jun 2001 18:32:28 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010618
X-Accept-Language: en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx
In-Reply-To: <10972.993257428@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well let me put it this way, I have in no way selected 'rebuild 
firmware' and several of my freshly untarred/patched to kernels are 
broken in that they won't compile, why?  lex not found.

Currently I'm pretty bothered because for any of numerous reasons now, I 
can't get the blasted aic7xxx support in any 2.4 kernel to work.  I'm a 
little tweaked because my distro is based on 2.4 functionality and I'm 
stuck on square 0 just trying to boot.

Several people have made reports about 2.4 and aic7xxx wrt to OOPSes, 
failure to boot, and hanging and there's very little response to this. 
 To this point I have two machines stuck in 2.2 which desperately need 
upgraded but I can't upgrade the kernel because the aic code is tragic.

Pardon my frustration,
David

[much snippage]


