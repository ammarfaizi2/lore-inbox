Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263008AbTCSNrs>; Wed, 19 Mar 2003 08:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263037AbTCSNrr>; Wed, 19 Mar 2003 08:47:47 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:61576 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263008AbTCSNrr>; Wed, 19 Mar 2003 08:47:47 -0500
Date: Wed, 19 Mar 2003 13:58:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Paul Rolland <rol@as2917.net>
Cc: "'Juha Poutiainen'" <pode@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: L2 cache detection in Celeron 2GHz (P4 based)
Message-ID: <20030319135841.GC28770@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Paul Rolland <rol@as2917.net>, 'Juha Poutiainen' <pode@iki.fi>,
	linux-kernel@vger.kernel.org
References: <20030319064743.GA1683@a28a> <00b801c2edf0$105d7750$6100a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b801c2edf0$105d7750$6100a8c0@witbe>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 09:18:04AM +0100, Paul Rolland wrote:

 > You can also add that the L1 detection doesn't seem to be correct
 > either : 
 > 0K Instruction cache, and 8K data cache for L1... This is not much
 > for instruction, it seems it should be 12K...

That should be fixed in recent 2.4s (and not-so-recent 2.5s).
What version are you seeing this problem on?

		Dave

