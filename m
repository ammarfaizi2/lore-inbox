Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268178AbTAKX4J>; Sat, 11 Jan 2003 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268183AbTAKX4J>; Sat, 11 Jan 2003 18:56:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:19847 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268178AbTAKX4I>;
	Sat, 11 Jan 2003 18:56:08 -0500
Date: Sun, 12 Jan 2003 00:02:53 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.56
Message-ID: <20030112000253.GD25493@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:26:56PM -0800, Linus Torvalds wrote:
 > 
 > Trying to make releases slightly more often and slightly smaller.
 > 
 > ACPI, USB, networking (mainly netfilter) updates. Some syscall path
 > updates and a thread bug in mm_release() that would miss updating the TID
 > and cause a few extra traps at exec time.
 > 
 > And a watchdog forward port from 2.4.x by DaveJ.

just to stem the number of 'this still isnt finished' reports I'm
getting, I'm working through the 2.4 diffs incrementally. I'm not
done yet, so please, be patient..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
