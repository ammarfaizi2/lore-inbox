Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263636AbTCUP1X>; Fri, 21 Mar 2003 10:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263638AbTCUP1W>; Fri, 21 Mar 2003 10:27:22 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:28053 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263636AbTCUP1W>; Fri, 21 Mar 2003 10:27:22 -0500
Date: Fri, 21 Mar 2003 15:38:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 AGP no good (VIA KT333, radeon 7500)
Message-ID: <20030321153820.GB3762@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Duncan Sands <baldrick@wanadoo.fr>, linux-kernel@vger.kernel.org
References: <200303211615.28675.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303211615.28675.baldrick@wanadoo.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 04:15:28PM +0100, Duncan Sands wrote:

 > X-windows starts, but the picture is horribly torn, only the grey stipple
 > pattern is recognizable.  Any thoughts?  Or should I start a binary
 > search for the last version that worked?

Strange, and this only happens when you have agpgart loaded ?

		Dave

