Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUHLC05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUHLC05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268358AbUHLCYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:24:49 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:51378 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S268356AbUHLCYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:24:25 -0400
Date: Thu, 12 Aug 2004 04:24:22 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <Pine.LNX.4.44.0408120413040.3142-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, Joerg Schilling wrote 

> As the people who did create the bastardized version of cdrecord
> you are using did not make clear where the official defaults file
> for cdrecord is located, they did violate the license of cdrecord.
>  
> It really does mot make fun to see useless forks for software including
> only modifications that do not give you a single advantage over the original.
>  
> The license used with cdrecord allows people to make modifications and to 
> rediustribute the versions. 
>  
> Not a single modification from one of the Linux distribution I did see so far
> did introduce any advantage over the original.
>  
> I would love to see cooperations (and there is cooperation with people from 
> many places), but the big Linux distributors all fail to cooperate :-(
>  
> Look into the mkisofs source, I even needed to include a comment in hope to
> prevent people from SuSE to convert legal and correct C code into a broken
> piece of code just because they modify things they don't understand :-(
>  
> Jörg

Hello Jörg,

i must agree here that getting cdrecord/cdrtools-2.0x going on the latest
SuSE 9.x editions has been extremely tiresome. Can it not be the case that
this has something todo with SuSE's inheritance to the UnitedLinux project?

I would like to suggest and kindly propose to maybe start cooperating
with Warly from MandrakeSoft. I think he has done a fine job sofar
in the latest Mandrake editions, 9.2 and 10.0 , making your cdrtools-2.0x
software run like it should. Warly is even by you mentioned as the only
one not violating your GPL licensed cdrtools package.

His efforts to get DVD burning rolling can be found at : 

http://people.mandrakesoft.com/~warly/files/cdrtools/
 
thanks,
best regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

