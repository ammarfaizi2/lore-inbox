Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUBWKff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 05:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUBWKff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 05:35:35 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:26030 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S261907AbUBWKfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 05:35:32 -0500
Date: Mon, 23 Feb 2004 11:35:30 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: distinguish two identical network cards
Message-ID: <20040223103529.GE4363@hout.vanvergehaald.nl>
References: <OF3A73498C.45F49506-ONC1256E43.002FC840@fiducia.de> <200402231437.17847.krishnakumar@naturesoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402231437.17847.krishnakumar@naturesoft.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:37:17PM +0530, Krishnakumar. R wrote:
> Hi,
> 
> If its physically identifying the cards that you want,  
> then you can  use 'ethtool' for it.  ' -p ' option of 
> ethtool will help you physically identify the cards.

Also, look into the 'nameif' utility.
It enables you to assign interface names to MAC addresses.
Great tool!

Regards,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
