Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317293AbSFMJwe>; Thu, 13 Jun 2002 05:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSFMJwe>; Thu, 13 Jun 2002 05:52:34 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:35509 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317293AbSFMJwc>; Thu, 13 Jun 2002 05:52:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Thu, 13 Jun 2002 11:37:46 +0200."
             <3D0867EA.8090809@loewe-komp.de> 
Date: Thu, 13 Jun 2002 19:55:41 +1000
Message-Id: <E17IRKP-0003lE-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D0867EA.8090809@loewe-komp.de> you write:
> Rusty Russell wrote:
> > *AND* the lock is persistent across reboots, since it's in a file.
> > How cool is that!
> > 
> 
> Don't want to bugg you: but you would have to clean them up in any case
> when you restart your system of cooperating programs.

Sorry, I should have added that I don't think it's cool in a *useful*
way.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
