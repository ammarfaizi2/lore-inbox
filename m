Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbTCTWdG>; Thu, 20 Mar 2003 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262844AbTCTWbk>; Thu, 20 Mar 2003 17:31:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:57300 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262749AbTCTWaz>;
	Thu, 20 Mar 2003 17:30:55 -0500
Subject: Re: [LTP] LTP version 20030306
From: Paul Larson <plars@linuxtestproject.org>
To: Doug Ramier <v2cibdr@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <OFA4093E14.AB316F7E-ON86256CEF.00784F88-86256CEF.0079F340@rchland.ibm.com>
References: <OFA4093E14.AB316F7E-ON86256CEF.00784F88-86256CEF.0079F340@rchland.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 Mar 2003 16:41:40 -0600
Message-Id: <1048200101.26917.228.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-20 at 16:12, Doug Ramier wrote:
> After overcoming problems with the compilation, we are getting between 50
> and 130 failures on 64 and 32 bit versions which with 20030206 we had on
> the order of a dozen.
Quick suggestion, instead of sending a flame out to everyone you can
think of, try sending some specific information about the problem you're
having the the appropriate mailing list (ltp-list).  Details will help
us solve your problem, ranting will not.

> I have a few questions:
> 1) Is everyone getting a "large" number of false failures?
No, again, details please

> 2) Are the tests checked out before being released by SourceForge?
Yes
> 3) Are the tests only verified on Intel?  How about PowerPC and iSeries?
We can verify on the hardware we have available to us.  Obviously we
don't have everything ever made, or even a sample of every architecture
supported by Linux.  Being an open source project we depend on others to
let us know when they are having problems on an architecture that we
don't have.  Are you volunteering?

> 4) Is there a version released after the release that has the 205 patches
> installed?
I'm not sure what "205 patches" you're referring to.  We make monthly
releases, and fixes are made to cvs in the interim.  You can pull from
the cvs tree to get the latest.

