Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSJAS6z>; Tue, 1 Oct 2002 14:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262211AbSJAS6z>; Tue, 1 Oct 2002 14:58:55 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:23948 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262209AbSJAS6p>;
	Tue, 1 Oct 2002 14:58:45 -0400
Date: Tue, 1 Oct 2002 20:06:48 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Cc: linux-kernel@vger.kernel.org, will@cs.earlham.edu
Subject: Re: [PATCH, TRIVIAL] 2.4.20-pre8 BeFS Config.in modification
Message-ID: <20021001190648.GA24193@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Garrett Kajmowicz <gkajmowi@tbaytel.net>,
	linux-kernel@vger.kernel.org, will@cs.earlham.edu
References: <200210011448.06125.gkajmowi@tbaytel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210011448.06125.gkajmowi@tbaytel.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 02:48:06PM -0400, Garrett Kajmowicz wrote:
 > I am planning on making an effort to move the relevent code for the Config.in 
 > files into the appropriate directory.  Attached is a simple patch which will 
 > do this for the BeFS.
 > 
 > Questions:
 > Is this appropriate for this list?
 > Are there any reasons not to do this?

If those filesystems had a dozen options each, it'd be worthwhile
perhaps. Saving 1-2 lines per-fs for the whole fs/Config.in
makes this seem not-so-worthwhile imo, but others may think otherwise..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
