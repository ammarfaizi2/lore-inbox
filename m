Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTBPOJN>; Sun, 16 Feb 2003 09:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTBPOJN>; Sun, 16 Feb 2003 09:09:13 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4736 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267026AbTBPOJM>;
	Sun, 16 Feb 2003 09:09:12 -0500
Date: Sun, 16 Feb 2003 14:30:05 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Brian Jackson <brian@mdrx.com>
Cc: linux-kernel@vger.kernel.org, brian@brianandsara.net
Subject: Re: 2.5 AGP for 2.4.21-pre4
Message-ID: <20030216143005.GA481@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Brian Jackson <brian@mdrx.com>, linux-kernel@vger.kernel.org,
	brian@brianandsara.net
References: <200302152135.22425.brian@mdrx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302152135.22425.brian@mdrx.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 09:35:22PM -0600, Brian Jackson wrote:
 > P.S.S. To Dave Jones -- I thought 2.5 had support for VIA chipsets & AGP3, but 
 > I only saw config options for the 7205/7505

If CONFIG_AGP3 is set, then the agp3 routines in via-agp.c also get
built, so you get KT400 support.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
