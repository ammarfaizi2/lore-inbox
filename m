Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTARO15>; Sat, 18 Jan 2003 09:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTARO15>; Sat, 18 Jan 2003 09:27:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:42927 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264818AbTARO15>;
	Sat, 18 Jan 2003 09:27:57 -0500
Date: Sat, 18 Jan 2003 14:33:54 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: perfctr-2.4.4 released
Message-ID: <20030118143354.GA23946@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200301181431.PAA14360@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301181431.PAA14360@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 03:31:19PM +0100, Mikael Pettersson wrote:
 > - Added preliminary support for AMD K8 processors with the
 >   regular 32-bit x86 kernel. The K8 performance counters appear
 >   to be identical or very similar to the K7 performance counters.

Whilst there are some that are the same, there are additionally a
bunch of new counters. I'll be adding support for these to
oprofile next week, so keep your eyes open 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
