Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSFEKXy>; Wed, 5 Jun 2002 06:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSFEKXx>; Wed, 5 Jun 2002 06:23:53 -0400
Received: from ns.suse.de ([213.95.15.193]:56081 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314446AbSFEKXx>;
	Wed, 5 Jun 2002 06:23:53 -0400
Date: Wed, 5 Jun 2002 12:23:53 +0200
From: Dave Jones <davej@suse.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler hints
Message-ID: <20020605122353.G5277@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Helge Hafting <helgehaf@aitel.hist.no>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1023206034.912.89.camel@sinai> <3CFDC796.C05FC7E2@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 10:11:02AM +0200, Helge Hafting wrote:
 > The problem is that this may be abused.  Someone nasty could
 > write a cpu hog that drops a lot of hints about being
 > interactive, starving real interactive programs.
 > 
 > Generally, it degenerates into application programmers
 > using _all_ the hints to get performance, so they
 > can beat some competitor in benchmarks.  And all
 > other programs just get penalized.

I can see how that would be a problem.
If I didn't have the source to $programs.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
