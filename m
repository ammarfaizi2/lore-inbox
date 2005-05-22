Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVEVOjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVEVOjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 10:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVEVOjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 10:39:43 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:8428 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261815AbVEVOjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 10:39:37 -0400
Date: Sun, 22 May 2005 16:39:33 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: Andrew Haninger <ahaning@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050522143933.GD13232@merlin.emma.line.org>
Mail-Followup-To: Patrick McFarland <pmcfarland@downeast.net>,
	Andrew Haninger <ahaning@gmail.com>, linux-kernel@vger.kernel.org
References: <200505201345.15584.pmcfarland@downeast.net> <105c793f050521182269294d64@mail.gmail.com> <200505220051.23222.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505220051.23222.pmcfarland@downeast.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2005, Patrick McFarland wrote:

> On Saturday 21 May 2005 09:22 pm, Andrew Haninger wrote:
> > > ... flames the LKML about how Linux breaks cdrecord
> > > (instead of just admitting cdrecord is broken)
> >
> > I've always used cdr-tools on Linux and Windows since it is the
> > only/best tool for mastering CDs. It takes the installation of Joerg's
> > library, but after that, it's worked wonderfully. This is even the
> > tool that is suggested by the HOWTOs that newbies are told to read. It
> > has always appeared to me that it was the only/best tool.
> 
> I was refering to the 2.6 permissions bug in cdrecord. It wouldn't work using 
> a non-root user, even if they had the correct permissions. 2.6 changed (for 

sudo works for me, and I'd rather use that than rely on someone writing
spaghetti code making this safe to use as suid code...

> I really wish someone would build a replacement for cdrecord, but Joerg just 
> hasn't pissed off that potential author enough.

Arrange for funding, find sponsors, and then hire someone.

-- 
Matthias Andree
