Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbTBIPHc>; Sun, 9 Feb 2003 10:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTBIPHc>; Sun, 9 Feb 2003 10:07:32 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:17879 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267280AbTBIPHc>;
	Sun, 9 Feb 2003 10:07:32 -0500
Date: Sun, 9 Feb 2003 15:13:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Spelling fixes for consistent, dependent, persistent
Message-ID: <20030209151320.GB12877@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200302090902.h1992KJ05999@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302090902.h1992KJ05999@hera.kernel.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 04:11:08PM +0000, Linux Kernel wrote:
 > ChangeSet 1.999, 2003/02/07 08:11:08-08:00, elenstev@mesatop.com
 > 
 > 	[PATCH] Spelling fixes for consistent, dependent, persistent
 > 	
 > 	This fixes the following common misspellings and their variants.
 > 	
 > 	  consistant -> consistent
 > 	  dependant  -> dependent
 > 	  persistant -> persistent
 >
 > <snip 83K patch>

Can we hold off on tree-wide 'corrections' like this until we at least
get closer to 2.6-test ? Doing these at this point in time really
screws over a lot of out-of-tree patches.

Oh, and Dependant is an allowed variation btw.[1][2]

		Dave

[1] http://www.m-w.com/cgi-bin/dictionary?va=dependant
[2] http://dictionary.reference.com/search?q=Dependant

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
