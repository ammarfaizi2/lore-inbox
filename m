Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267390AbUG2BDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267390AbUG2BDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267392AbUG2BDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:03:17 -0400
Received: from holomorphy.com ([207.189.100.168]:24976 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267390AbUG2BDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:03:14 -0400
Date: Wed, 28 Jul 2004 18:03:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Message-ID: <20040729010311.GM2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200407242156.40726.gene.heskett@verizon.net> <200407250037.51874.gene.heskett@verizon.net> <20040729001234.GK2334@holomorphy.com> <200407282059.03524.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407282059.03524.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:59:03PM -0400, Gene Heskett wrote:
> This message is now a bit old, William. 
> I was watching the psu voltages via gkrellm, and was seeing the 5 volt 
> line go from 4.89, down to 4.73 in consecutive readings.  The new 420 
> watt Antec, seems to be steadier at 4.87 +- 0.03 or so.
> I suspect the tap point for the xx83627 chips input may not be right 
> at the psu connector on the mobo cause I suspect the supply itself is 
> probably doing 5.05 or so, although I haven't dropped my DVM on the 
> line to test, its rather buried behind the drive cage.  But lemme go 
> hit a drive power connector since there are spares on this psu, brb.  
> Yeah, at a drive cables middle connector, with a small load on the 
> end, its sitting at 5.00 volts, solid as a rock.  This supply has 
> seperate regulators for the 5 volt, and 3.3 volt lines where the 
> older one regulated everything against the 5 volt by turns ratios on 
> the transformer, and was only a 300 watter, with 2 hd's, 2 floppy's 
> and a dvd writer in addition to the motherboard load.
> Anything else a C.E.T. can get for you?

The question is really whether all this is actually causing observable
kernel/cpu/device failures.


-- wli
