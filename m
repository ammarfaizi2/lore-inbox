Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTBJWRI>; Mon, 10 Feb 2003 17:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTBJWRI>; Mon, 10 Feb 2003 17:17:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:17639 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265382AbTBJWRH>;
	Mon, 10 Feb 2003 17:17:07 -0500
Date: Mon, 10 Feb 2003 22:22:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon adv speculative caching fix removed from 2.4.20?
Message-ID: <20030210222248.GA14640@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Oliver Feiler <kiza@gmx.net>, linux-kernel@vger.kernel.org
References: <200302102321.30549.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302102321.30549.kiza@gmx.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:21:24PM +0100, Oliver Feiler wrote:

 > Can someone point to a why this was removed, maybe a different fix since the 
 > one mentioned says "Short-term fix" or is it not needed anymore for some 
 > reason?

A better fix went in. See the changes to agpgart.

		Dave
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
