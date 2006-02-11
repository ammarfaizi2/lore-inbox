Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWBKXfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWBKXfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 18:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWBKXfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 18:35:19 -0500
Received: from smtpout.mac.com ([17.250.248.86]:11257 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750845AbWBKXfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 18:35:18 -0500
In-Reply-To: <200602111136.56325.merka@highsphere.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <200602111136.56325.merka@highsphere.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com>
Cc: suspend2-devel@lists.suspend2.net, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 11 Feb 2006 18:35:07 -0500
To: Jan Merka <merka@highsphere.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11, 2006, at 11:36, Jan Merka wrote:
> On Friday 10 February 2006 18:35, Pavel Machek wrote:
>> Anyway, it means that suspend is still quite a hot topic, and that  
>> is good. (Linus said that suspend-to-disk is basically for people  
>> that can't get suspend-to-RAM to work, and after I got suspend-to- 
>> RAM to work reliably here, I can see his point).
>
> I strongly disagree. I got suspend-to-RAM to work but its utility  
> is seriously limited by battery capacity. For example, on my laptop  
> (Sony VGN-B100B) with 1.5GB of RAM, a fully charged battery is  
> drained in about 18 hours if the laptop was suspended to RAM.

Ick, that's kind of sucky hardware then.  My PowerBook with 1GB RAM  
easily gets a week of sleep time off a fully charged battery; I don't  
think I've rebooted it _once_ in the last 2 months, I just leave it  
sleeping in my bag the whole time.  Sony must be doing something  
wrong, because there's easily enough power in a single battery to  
keep RAM refreshed for a _long_ time.

> Yes, for a few hours suspend-to-RAM is convenient but suspend-to- 
> disk is _reliable_ and _safe_.

As to the safety issue, I have my Apple Powerbook configured to  
suspend to RAM, and if it gets critically low on battery I have the  
firmware set to resume it automatically and my scripts shut it down  
so I don't lose data.  Suspend-to-RAM when implemented properly _is_  
reliable and safe, but it seems like a lot of hardware manufacturers  
get it wrong.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



