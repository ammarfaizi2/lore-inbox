Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270624AbRHNNQa>; Tue, 14 Aug 2001 09:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270623AbRHNNQU>; Tue, 14 Aug 2001 09:16:20 -0400
Received: from home.paris.trader.com ([195.68.19.162]:46296 "EHLO
	smtp-gw.netclub.com") by vger.kernel.org with ESMTP
	id <S270621AbRHNNQH>; Tue, 14 Aug 2001 09:16:07 -0400
Message-ID: <3B7924C7.31923A8@trader.com>
Date: Tue, 14 Aug 2001 15:16:55 +0200
From: joseph.bueno@trader.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Schwartz =?ISO-8859-1?Q?=1A?= <davids@webmaster.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something that can be done against this ???
In-Reply-To: <NOEJJDACGOHCKNCOGFOMKENKDCAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 
> > The question is not : "is this script dangerous ?",
> > but "are you ready to blindly execute a shell script
> > (or any program) that you receive in your  mail ?".
> 
>         Sure, as a user created solely for that purpose, it should be entirely
> safe.
> 

How many users are there that use a specific user account to read
their emails on their Linux workstation ?
I don't, I use my account to read mails, write documents,
develop programs,etc. So even if a malicious program does
not do any arm to the system, it can at least destroy or corrupt my
own files and I will loose time restoru=ing from last backup and
rebuilding recently modified files.

> > I don't care if this script is dangerous or not because I will
> > never execute it,
> > or any program that I receive my email before checking its
> > contents and making sure
> > it is OK.
> > (And my mail reader will not execute anything automatically, not
> > even Javascript).
> 
>         Why? Is it because you don't trust your system security? Your operating
> system shouldn't let the script do anything you don't want it to do.

Yes I trust my system security. But even the system is not affected,
since the script will run with my userid, it will be able to do everything
I am allowed to do.

> 
> > If somebody is dumb enough to execute any  program received by email,
> > don't loose time trying to find some weaknesses in the system; just
> > send him a shell script with "rm -rf /". It will do enough harm !
> 
>         That should do no harm. What you mean to say is "if somebody is dumb enough
> to execute any program recieved by email under a user account that has
> permissions to modify files he cares about, consume too many process slots,
> consume excessive vm, or has other special capabilities".

It was just a one line example. Even if does not do any harm to
system files, it will harm my own files !

BTW, how many people are positively sure that they can
run "su nobody -c rm -rf /" on their system without loosing anything ?

> 
> > Best protection against mail virus is not technical (although it
> > may help),
> > but user education; and this is true regardless of which operating system
> > or mail reader is used !
> 
>         If a user can run code that can harm the system, then nobody who isn't
> trusted not to harm the system can be a user. That's not how we want Linux
> to be, is it?

Well, you are right; but even if a user does not harm the system,
he will harm himself and there is no way the system can protect him
against it. So we are back to my point: user protection comes from
user education.

> 
>         DS
> 
Regards
--
Joseph Bueno
NetClub/Trader.com
