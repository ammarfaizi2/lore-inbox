Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316865AbSEVGIX>; Wed, 22 May 2002 02:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316866AbSEVGIW>; Wed, 22 May 2002 02:08:22 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:12263 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S316865AbSEVGIV>; Wed, 22 May 2002 02:08:21 -0400
Message-Id: <200205220605.g4M65cI14609@colombe.home.perso>
Date: Wed, 22 May 2002 08:05:35 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: nVidia NIC/IDE/something support?
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020517002947.G116@toy.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17 Mai, Pavel Machek a écrit :
> Hi!
> 
>> > One thing I've found for nForce chipset: official patches from nVidia 
>> > (network driver is under nVidia's licence, all the rest is under GPL).
>> > Hope that helps:
>> > 
>> > http://www.nvidia.com/view.asp?IO=linux_nforce_1.0-0236
>> 
>> Unfortunately the license you must agree to says it is all nvidia license
>> and furthermore contains clauses illegal in the UK. If Nvidia was to submit
>> any GPL bits they wanted merged without such stuff it would be useful
> 
> That's probably simple error by nvidia...
> 								Pavel

nvidia help for swsusp would be nice also. I tried the patch on my
desktop for the first time and it seems to work reliably (even from X)
except that 3D is lost after resume. That's rather curious: menus
without highlights or things like that.

--
Florent Chabaud
http://www.ssi.gouv.fr | http://fchabaud.free.fr

