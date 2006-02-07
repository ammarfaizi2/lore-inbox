Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWBGUEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWBGUEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBGUEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:04:06 -0500
Received: from smtpout.mac.com ([17.250.248.87]:55523 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932400AbWBGUEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:04:05 -0500
In-Reply-To: <43E8F8EB.8010800@shaolinmicro.com>
References: <20060207044204.8908.qmail@science.horizon.com> <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com> <43E8F8EB.8010800@shaolinmicro.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <52661F74-CB8F-4802-82F9-849769A968CB@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Linux drivers management
Date: Tue, 7 Feb 2006 15:03:51 -0500
To: David Chow <davidchow@shaolinmicro.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 07, 2006, at 14:45, David Chow wrote:
> Before I continue this discussion, I would really want to clarify  
> who am I before get discriminated by end-users and developers,  
> because I am both.
>
> [offtopic babble about credentials]

We do not discriminate based on "end-user" or "developer", we  
discriminate based on productivity.  So far this thread has been  
extremely counterproductive and wasted a lot of my bandwidth and  
time.  As a result, I am now discriminating against you for wasting  
my time.  Welcome to my killfile.  (I still felt the need to point  
out your grievous logical errors, but don't bother replying because  
this is the last time I'm going to bother wasting time on this thread)

> [junk about commercial development models]

We do not care about your snazzy dev-model ideas, we have one that  
works for us.  We do not care about making things easier for  
commercial out-of-tree drivers, _end_ _of_ _story_.  Any arguments  
about that issue are just offtopic flames.
> Why would the maintainers bother to maintain the drivers if the  
> driver development work is now back to the hardware vendor, like  
> drivers for other platform did? I think someone mis-understood the  
> whole idea is to "GET RID OF DRIVER MAINTENANCE", belive it or not,  
> it belongs to the vendor, not here. If the driver releases as GPL,  
> you can still make your own changes, but it doesn't have to be in  
> main source tree.

WRONG.  Driver maintenance is a 2-part effort.  The Linux kernel API  
is *not* stable for a lot of good reasons, and therefore the drivers  
must be in-tree to make it possible to fix drivers when we change the  
API.  Hardware companies are _expected_ to be good citizens and  
maintain their own drivers, fix bugs, etc.  If your driver sucks,  
nobody will buy your hardware to use on linux.

> Linux will not sail to major desktop unless a decent DDK (driver  
> development kit) exists.

This is wrong.  There are a lot of companies that make great server  
hardware out there whose drivers are in the stock kernel, and by your  
argument "Linux will not sail to major servers unless a decent DDK  
exists", which is blatantly false.

> /Documentation/stable_api_nonsense.txt is only a document totally  
> written by a programmer sense

Absolutely, and from the programmer point of view, that's all that  
matters.

> its nothing about people who don't want to compile the drivers

This is the job of a distro

> and has assumed drivers should be maintained by the community.

Community includes the people making the hardware

> But strictly speaking, it shouldn't. Please refer to the process of  
> making a driver from a manufacturers point of view and consider  
> user using old OS'es which don't want to upgrade.

You don't want to upgrade, you don't get new hardware support, simple  
as that.  Upgrading my Debian testing between 2.6 versions has been  
really painless despite massive internal changes and restructuring,  
and Debian isn't really even a user-friendly distro.

> but freedom of speech exists, right?

As does my freedom to ignore you. Plonk.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



