Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbSLTKT5>; Fri, 20 Dec 2002 05:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbSLTKT5>; Fri, 20 Dec 2002 05:19:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30882 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266298AbSLTKTz>;
	Fri, 20 Dec 2002 05:19:55 -0500
Date: Fri, 20 Dec 2002 10:27:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Michael Milligan <milli@acmeps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Broken AGP initialization for i845G chipset [patch]
Message-ID: <20021220102715.GE24782@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Michael Milligan <milli@acmeps.com>, linux-kernel@vger.kernel.org
References: <3E025858.4000404@acmeps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E025858.4000404@acmeps.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 04:38:00PM -0700, Michael Milligan wrote:
 > 
 > Patch below.  Calls the 845 initialization function instead of the 830MP,
 > and a small formatting cleanup.  This is verified working.

With testgart/some other AGP using app ?
 
It looks totally logical. I'm just wondering if it was a cut-n-paste
accident, or someone had a genuine reason for doing that in the
first place.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
