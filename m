Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271015AbTGPRnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271001AbTGPRlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:41:52 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:41875 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270993AbTGPRl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:41:26 -0400
Date: Wed, 16 Jul 2003 18:55:35 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Valdis.Kletnieks@vt.edu, vojtech@suse.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716175534.GA25712@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>, Valdis.Kletnieks@vt.edu,
	vojtech@suse.cz, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <200307161710.h6GHAsU1001493@turing-police.cc.vt.edu> <20030716171706.GN833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716171706.GN833@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:17:06PM +0200, Jens Axboe wrote:
 > > Dumb user question - which rippers support SG_IO?  I've been using
 > > cdparanoia mostly for lack of a good reason to migrate - but this
 > > sounds like a good reason. ;)
 > 
 > Not a dumb question at all, see my previous mail :). In short, I don't
 > know. I'm sure a little collective effort could hunt some down (cdda2wav
 > should work, since it uses libscg presumable).

For info, I just tried cdda2wav, and whilst it used less CPU than
cdparanoia, the dancing mouse effect still occurs 8-(

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
