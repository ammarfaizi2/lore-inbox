Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTJVDwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 23:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTJVDwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 23:52:22 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:17939 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S263426AbTJVDwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 23:52:21 -0400
Date: Tue, 21 Oct 2003 23:52:16 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: uml-patch-2.6.0-test8
Message-ID: <20031022035215.GA4291@fieldses.org>
References: <200310212018.h9LKILeg002739@ccure.karaya.com> <200310212115.h9LLFneg003091@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310212115.h9LLFneg003091@ccure.karaya.com>
User-Agent: Mutt/1.3.28i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 05:15:49PM -0400, Jeff Dike wrote:
> Some moron said:
> > This patch updates UML to 2.6.0-test8.
> > The 2.6.0-test5 UML patch is available at
> > 	http://jdike.stearns.org/mirror/uml-patch-2.6.0-test8.bz2 
> 
> That patch was bogus.  I replaced it with a good one, so pull it again if it
> totally breaks for you.

I downloaded the patch from the URL above; it doesn't seem to have any
hostfs code in it.

Applying the /fs/ parts of the -test5 patch seems to work for
now....--Bruce Fields
