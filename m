Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262338AbSI1WFI>; Sat, 28 Sep 2002 18:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262337AbSI1WFH>; Sat, 28 Sep 2002 18:05:07 -0400
Received: from meel.hobby.nl ([212.72.224.15]:10504 "EHLO meel.hobby.nl")
	by vger.kernel.org with ESMTP id <S262338AbSI1WFH>;
	Sat, 28 Sep 2002 18:05:07 -0400
Date: Sun, 29 Sep 2002 00:03:32 +0200
From: Toon van der Pas <toon@vanvergehaald.nl>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020929000332.A16506@vdpas.hobby.nl>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020928134457.A14784@brodo.de>; from linux@brodo.de on Sat, Sep 28, 2002 at 01:44:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 01:44:57PM +0200, Dominik Brodowski wrote:
> 
> This add-on patch is needed to abort on Dell Inspiron 8000 / 8100
> which would lock up during speedstep.c and to resolve an oops
> (thanks to Hu Gang for reporting this)
> 
> 	Dominik

Wait a minute...
Do I understand you and your patch right?
Dell sells a machine with a Pentium III Mobile CPU with Speedstep
technology, and now you tell us that it won't work?  Ever?
Does this mean that a lot of people (including me) bought a very
advanced and expensive piece of trash?  Then it's about time that
I contact Dell, because they screwed me.

Does Speedstep work on this machine with Windows/XP?
(I never checked, removed it first thing after unpacking the machine.)

Regards,
Toon.
-- 
 /"\                             |
 \ /     ASCII RIBBON CAMPAIGN   |  "Who is this General Failure, and
  X        AGAINST HTML MAIL     |   what is he doing on my harddisk?"
 / \
