Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbUKJBf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUKJBf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUKJBf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:35:28 -0500
Received: from smtpout.mac.com ([17.250.248.88]:20466 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261825AbUKJBe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:34:59 -0500
In-Reply-To: <1100042579.16729.7.camel@localhost.localdomain>
References: <MDEHLPKNGKAHNMBLJOLKAEKLPKAA.davids@webmaster.com> <1100042579.16729.7.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AF8A1638-32B8-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davids@webmaster.com, Dmitry Torokhov <dtor_core@ameritech.net>,
       =?ISO-8859-1?Q?Rapha=EBl_Rigo_LKML?= <lkml@twilight-hall.net>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL Violation of 'sveasoft' with GPL Linux Kernel/Busybox +code
Date: Tue, 9 Nov 2004 20:34:38 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 09, 2004, at 18:22, Alan Cox wrote:
> On Maw, 2004-11-09 at 19:30, David Schwartz wrote:
>> 	Look, this really is simple. When the GPL talks about "additional
>> restrictions", it doesn't mean the restrictions found in the GPL. It 
>> means
>> restrictions found elsewhere, such as in private contracts. (Where 
>> else
>> would the restrictions be?!)
>
> It talks about additional restrictions imposed on your GPL granted
> rights. It seems very simple to me. Future upgrade services are a
> seperate contractual matter. Your whole position is positively
> ridiculous. Very large amounts of GPL code is released where you don't
> get updates, ever, whatever you do. Yet you don't object to those.

In this case however, you buy the right to future updates for $20.  
This is
a contract between you and SveaSoft that essentially says:
> If you pay SveaSoft $20, you will receive all updates for the next 
> year.
> If you chose to exercise your GPL right to redistribute, however, you
> will lose the subscription you paid $20 for."

The penalty for exercising your GPL distribution right is losing your
$20 subscription.  I believe that such a penalty is a restriction on you
exercising your GPL rights.  Such a restriction, when added upon the
GPL license through which SveaSoft can distribute Linux, violates
Section 6 of the GPL:
> [...]
> You may not impose any further restrictions on the recipients'
> exercise of the rights granted herein.
> [...]

Therefore, I propose that under Section 4 of the GPL, SveaSoft has
lost its license to distribute the Linux kernel.
> You may not copy, modify, sublicense, or distribute the Program
> except as expressly provided under this License.  Any attempt
> otherwise to copy, modify, sublicense or distribute the Program is
> void, and will automatically terminate your rights under this
> License.

All of this is just the opinion of a concerned hacker, not a lawyer so
it may be completely bogus.  I _do_ believe, however, that SveaSoft's
actions violate the spirit of the GPL, especially given actions like 
this:

http://www.neuromancer.ca/wrt54g/   -   Scroll down to the bottom,
the part with the email to Yahoo by SveaSoft.

Apparently SveaSoft isn't happy with restricting users by having
them sign away their GPL rights, it is attempting to use FUD to
prevent users from distributing SveaSoft binaries or sources.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


