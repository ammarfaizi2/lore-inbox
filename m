Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSKCDpH>; Sat, 2 Nov 2002 22:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSKCDpH>; Sat, 2 Nov 2002 22:45:07 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:60677 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261585AbSKCDpG>; Sat, 2 Nov 2002 22:45:06 -0500
Date: Sun, 3 Nov 2002 03:51:27 +0000
From: John Levon <levon@movementarian.org>
To: Anton Blanchard <anton@samba.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] performance counters 3.1 for 2.5.45 [1/4]: x86 support
Message-ID: <20021103035127.GA79202@compsoc.man.ac.uk>
References: <200210312310.AAA07606@kim.it.uu.se> <20021101192201.GC2746@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101192201.GC2746@krispykreme>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *188BnL-000BDC-00*qZ.FrrFnP.6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[snipped linus]

On Sat, Nov 02, 2002 at 06:22:01AM +1100, Anton Blanchard wrote:

> Any chance that this and oprofile could share a common base? We are
> interested in both oprofile and straight performance counting on
> ppc64 and Id prefer not to implement the arch bits twice.

Yes, it would be nice to do this. But I'm not sure what form this should
take (yet)

regards
john

-- 
"My first thought was I don't have any makeup. How will I survive
without my makeup ? My second thought was I didn't have any identification.
Who am I ?"
	- Earthquake victim
