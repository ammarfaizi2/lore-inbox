Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVALVN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVALVN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVALVCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:02:46 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:7856 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261448AbVALU61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:58:27 -0500
Message-ID: <41E59134.8030908@gadugi.org>
Date: Wed, 12 Jan 2005 14:05:56 -0700
From: jmerkey <jmerkey@gadugi.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Pollei <stephen_pollei@comcast.net>
Cc: root <root@mail.gadugi.org>, Valdis.Kletnieks@vt.edu,
       christos gentsis <christos_gentsis@yahoo.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Cherokee Nation Posts Open Source Legisation - Invites comments
 from Community Members
References: <20050106180414.GA11597@mail.gadugi.org>	<200501061836.j06IakHo030551@turing-police.cc.vt.edu>	<20050106183725.GA12028@mail.gadugi.org>	<200501061935.j06JZMq4013855@turing-police.cc.vt.edu>	<41E4CBC3.4070302@yahoo.co.uk>	<200501120849.j0C8nkxI000704@turing-police.cc.vt.edu> 	<20050112171855.GA23106@mail.gadugi.org> <1105561039.974.12.camel@fury>
In-Reply-To: <1105561039.974.12.camel@fury>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The current Gadugi implementation has compiled the Linux kernel as a 
standalone elf64 module that loads as
an application on the Gadugi kernel, with the /arch portions stripped 
and mapped into Gadugi.  Gadugi has it's
own elf64 loader (non-GPL). The GPL language states that the "collective 
work" definition refers to code sections
which constitute part of a "whole" unpo which the "separate" work in based.

This is a collective work which is "not based upon Linux", Linux runs as 
a kernel app.  Provided the two
code bases remain separate, there are no GPL issues with the current 
language.  Gadugi is a separate
elf64 module with it's own loader, services, etc.  The fact that Linux 
is now "based on" another operating
system reverses the license language (thanks Richard S. for inserting 
this) and the GPL also states
that independent works are "separate" and not affected by this license. 

I realize there may be many people who take issue with this, but this is 
the laguage, and yes, GPL code can be taken and
used this way.  The two code bases are maintained seprately and not 
compiled together.  But Linux can be loaded
as as Elf application, and in this sense it is a "seperate" work and 
whole in itself.   



Stephen Pollei wrote:

>On Wed, 2005-01-12 at 09:18, root wrote:
>OK I've replied to this as well at
>http://www.gadugi.org/article.php?story=20041221121621283 ...
>I think that your understanding of the implications of the GPL seem to
>be dangerously flawed in some respects.
>  
>
>>There is no impact on the GPL and any Linux code covered under the GPL
>>remains as such.  The Ga-du-gi OS is defined under the current FSF 
>>definitions as a "collective work" not a "derivative work".  So all the
>>folks sending mail to LKML and gadugi.org that implies otherwise
>>are out in the weeds.  
>>    
>>
>
>The below should also be at the above mentioned url...
>
>OK the extent of the fork has been mentioned.
>However you should note that both the GPL and LGPL only give conditional
>permission to include code licensed under those terms into "collective
>works". Your code that is under "/arch" sure sounds like it is
>interdependant with the rest of the kernel code. Further it is not a
>"separate work" and a kernel compiled with your "arch" changes can't be
>shipped into two independant separate binaries-- it forms one
>inseparable whole that contains incompatibily licensed code. The GPL
>doesn't give anyone permission to include code licensed under those
>terms in these conditions.
>
>It would be instructive for you to compare and contrast the GPL and the
>LGPL to notice that altogether not giving permission to create
>inseparable, dependent works that add restrictions was *intended*. If
>the developers wanted to allow you to do what it is you are attempting
>they would have choosen the LGPL or another license.
>
>You should note that the kernel developers would like to see more
>successful Linux forks -- you are in fact given an explicit license to
>create forks the GPL. However that is your only license to do so and if
>you choose to ignore it's boundaries after being repeatiibly and
>publicly warned, then you are likely to incure civil liabilites from
>being found a willful premeditated copyright infringer in a few
>jurisdictions around the world.
>
>I strongly suggest that instead of assuming that you seek competent
>legal advice or take an educational seminar, read a faq or two or
>otherwise education yourself to what the GPL implies.
>
>So please instead of complaining that people are "out in the weeds" or
>creating a "smoke screen". Maybe you should listen a little.
>
>http://www.ussg.iu.edu/hypermail/linux/kernel/0501.1/1425.html
>http://www.fsf.org/licenses/gpl.txt
>http://www.fsf.org/licenses/lgpl.txt
>http://patron.fsf.org/course-offering.html
>http://www.fsf.org/licenses/gpl-faq.html
>
>  
>

