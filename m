Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289061AbSAIWef>; Wed, 9 Jan 2002 17:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSAIWeX>; Wed, 9 Jan 2002 17:34:23 -0500
Received: from fysh.org ([212.47.68.126]:36102 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S289056AbSAIWeO>;
	Wed, 9 Jan 2002 17:34:14 -0500
Date: Wed, 9 Jan 2002 22:34:14 +0000
From: Athanasius <Athan@gurus.tf>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon XP 1600+ and _mmx_memcpy symbol in modules
Message-ID: <20020109223413.GK15688@gurus.tf>
Mail-Followup-To: Athanasius <Athan@gurus.tf>, linux-kernel@vger.kernel.org
In-Reply-To: <20020109182224.GI15688@gurus.tf> <m16OO2K-000OVeC@amadeus.home.nl> <20020109220821.GJ15688@gurus.tf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109220821.GJ15688@gurus.tf>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 10:08:21PM +0000, Athanasius wrote:
> On Wed, Jan 09, 2002 at 07:05:20PM +0000, arjan@fenrus.demon.nl wrote:
> > you forgot to make mrproper ;) (or at least make clean)
> > yes the makefile for modversions is missing a dependency......
> 
>    I'll recheck with 'make mrproper' as I do always do a 'make clean'
> (and dep for that matter) after changing configuration at all.

   Yup, 'make mrproper' followed by the usual steps gives me a thus-far
working kernel and modules.

thanks again,

-Ath
-- 
- Athanasius = Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
