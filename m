Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264013AbTCWX6f>; Sun, 23 Mar 2003 18:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264009AbTCWX6f>; Sun, 23 Mar 2003 18:58:35 -0500
Received: from pop.gmx.de ([213.165.64.20]:16350 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264013AbTCWX6d>;
	Sun, 23 Mar 2003 18:58:33 -0500
Message-ID: <3E7E4C63.908@gmx.de>
Date: Mon, 24 Mar 2003 01:08:03 +0100
From: Sven Schuster <schuster.sven@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de-de, en, en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323195334.GA11127@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Sun, 23 March 2003 14:38:10 -0500, Alan Cox wrote:
>  
>
>>-	Anyone can go and release their own 2.4.20.1 or 2.4.20-sec or
>>	whatever if they feel strongly about it
>>
>>Just go do it. If someone wants to be a contact point for build existing
>>base kernels + published security fix trees I'm pretty sure kernel.org
>>would host them too.
>>    
>>
>
>Sounds like a good idea. Ideal would be a person with a lottle
>knowledge about security or at least, about this particular patch.
>
>I would volunteer, if noone else does. But just about anyone would be
>closer to that ideal person, so consider me to be the last resort.
>
>Jörn
>  
>

I think a solution like this would be best, having a "-fix" tree or 
similar for
the latest stable kernel maintained by a volunteer and hosted by kernel.org.

Optionally or alternatively there could/should be a mailinglist (yes, 
one more
:-) where all critical fixes like sec + fs fixes, etc. are posted to, for
people building their own kernels (and interested in staying up-to-date) 
but
not willing/having the time/able to dig through the tons of emails 
brought by
lkml.
Cause I think if you're not an active kernel developer or having some 
issues
with running a kernel, or like me, just interested and still learning to
understand linux kernel programming in the far future ;-) you shouldn't have
to read lkml just for building and maintaining your own, none-vendor 
kernel.
Btw, if you had to, I think there might even be the danger of loosing some
critical fixes in the loads of emails.

Sven
   

