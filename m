Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317397AbSGDMS4>; Thu, 4 Jul 2002 08:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSGDMSz>; Thu, 4 Jul 2002 08:18:55 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:39437 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317397AbSGDMSz>; Thu, 4 Jul 2002 08:18:55 -0400
Date: Thu, 4 Jul 2002 13:21:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rob Landley <landley@trommello.org>
Cc: Dave Jones <davej@suse.de>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020704132120.C11601@flint.arm.linux.org.uk>
References: <Pine.LNX.3.96.1020701140915.23920A-100000@gatekeeper.tmr.com> <20020703173421.B8934@suse.de> <20020703200044.EB039C2C@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020703200044.EB039C2C@merlin.webofficenow.com>; from landley@trommello.org on Wed, Jul 03, 2002 at 10:24:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 10:24:20AM -0400, Rob Landley wrote:
> And leaving stabilization to the people who care about stabilization
> would be a bad thing why?

Think about who will do the stabilisation.  Do you really think Alan or
Marcelo will pick up 2.6 when it comes out?  Or do you see someone else
picking up 2.6?

One of the fundamental questions that needs to be asked along side the
"fork 2.7 with 2.6" problem is _who_ exactly is going to look after 2.6.
Dave Jones?  If Dave, who's going to do Daves job of making sure fixes
get propagated between stable and development trees?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

