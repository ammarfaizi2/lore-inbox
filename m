Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbTCSQuT>; Wed, 19 Mar 2003 11:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbTCSQuS>; Wed, 19 Mar 2003 11:50:18 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:4248 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263152AbTCSQuQ>; Wed, 19 Mar 2003 11:50:16 -0500
Date: Wed, 19 Mar 2003 17:01:06 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Paul Rolland <rol@as2917.net>
Cc: "'Juha Poutiainen'" <pode@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: L2 cache detection in Celeron 2GHz (P4 based)
Message-ID: <20030319170106.GC19361@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Paul Rolland <rol@as2917.net>, 'Juha Poutiainen' <pode@iki.fi>,
	linux-kernel@vger.kernel.org
References: <20030319135841.GC28770@suse.de> <013d01c2ee38$0812e330$6100a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013d01c2ee38$0812e330$6100a8c0@witbe>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 05:53:13PM +0100, Paul Rolland wrote:

 > >  > You can also add that the L1 detection doesn't seem to be correct
 > >  > either : 
 > >  > 0K Instruction cache, and 8K data cache for L1... This is not much
 > >  > for instruction, it seems it should be 12K...
 > > 
 > > That should be fixed in recent 2.4s (and not-so-recent 2.5s).
 > > What version are you seeing this problem on?
 > 
 > Quite a recent one : 2.4.20.

Fixed as of 2.4.21pre1. The fix went in on 2nd December, and pre1 was
tagged as of the 10th December.
 
		Dave

