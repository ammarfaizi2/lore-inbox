Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBOUau>; Thu, 15 Feb 2001 15:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129528AbRBOUak>; Thu, 15 Feb 2001 15:30:40 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:41468 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S129107AbRBOUaa>; Thu, 15 Feb 2001 15:30:30 -0500
Date: Thu, 15 Feb 2001 12:28:36 -0800
From: Chip Salzenberg <chip@valinux.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "Justin T . Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans
Message-ID: <20010215122836.B30852@valinux.com>
In-Reply-To: <85F1402515F13F498EE9FBBC5E07594220AD85@TTGCS.teamtoolz.net> <200102151747.f1FHlDO64938@aslan.scsiguy.com> <20010215212007.A995@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010215212007.A995@werewolf.able.es>; from jamagallon@able.es on Thu, Feb 15, 2001 at 09:20:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to J . A . Magallon:
> Please, I think it would be much more useful a patch against the latest
> 2.2.19-pre (if that one for 2.2.18 does not work, I have not tried)
> and the latest 2.4.1-ac14, that is what people experiments with.

There's no end of versions that people use.

Might I suggest that Justin imitate the maintainers of lm_sensors, and
create a program (shell script, Perl program, whatever) that *creates*
a patch against any given Linux source tree?  Obviously it could break
in the face of weird trees, but even minimal flexibility would save him
a lot of work ...
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
