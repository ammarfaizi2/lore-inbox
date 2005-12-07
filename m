Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVLGFOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVLGFOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 00:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVLGFOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 00:14:36 -0500
Received: from smtpout.mac.com ([17.250.248.71]:31692 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932217AbVLGFOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 00:14:35 -0500
In-Reply-To: <200512061622.54583.gene.heskett@verizon.net>
References: <200512050031.39438.gene.heskett@verizon.net> <4395798D.6040201@eclis.ch> <200512061402.08709.gene.heskett@verizon.net> <200512061622.54583.gene.heskett@verizon.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0E093DF2-A72F-4A76-9BF6-8D7E9B1AF31F@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: ntp problems
Date: Wed, 7 Dec 2005 00:14:30 -0500
To: Gene Heskett <gene.heskett@verizon.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 06, 2005, at 16:22, Gene Heskett wrote:
> That one installed without any hiccups, but I saw where the sign-on  
> said it was DDR400 dual channel ram, whereas before the update it  
> was DDR333 dual channel ram.  As the XP2800 athlon isn't rated for  
> DDR400, I backed into the bios and reset the fsb for 166 mhz which  
> should give me a 333
> fsb.  But it still says DDR400 at signon.  So I guess we'll see if  
> its now stable at a 400 mhz fsb even if its set to 166/333.

Hmm, this sounds a lot like the BIOS insanity we saw on one cheapo  
Chaintech board.  We knew it was bad when the thing reported in its  
boot display that the CPU was an "Intel Athlon".  Things only got  
worse from there; but sadly there was no BIOS update, and we ended up  
throwing away the $35 board just on general principles :-D.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


