Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317981AbSHICvJ>; Thu, 8 Aug 2002 22:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSHICvJ>; Thu, 8 Aug 2002 22:51:09 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:9861 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317981AbSHICvI>;
	Thu, 8 Aug 2002 22:51:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Date: Fri, 9 Aug 2002 04:56:46 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, jmacd@namesys.com, rml@tech9.net
References: <20020808172335.GA29509@sgi.com> <Pine.LNX.4.44L.0208081435400.2589-100000@duckman.distro.conectiva> <20020808173933.GA29474@sgi.com>
In-Reply-To: <20020808173933.GA29474@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17czxG-0000e8-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 August 2002 19:39, Jesse Barnes wrote:
> On Thu, Aug 08, 2002 at 02:36:46PM -0300, Rik van Riel wrote:
> > Looks fine to me, but I'm not a SCSI guy so you'll have to
> > ask them about integrating the patch ;)
> 
> Oh, I meant that I removed those changes _from my patch_.  Now they're
> confined to x86 and ia64 header files and some generic files.  I'm not
> sure who to send it to now (Linus?).

Or Andrew Morton, or both.

-- 
Daniel
