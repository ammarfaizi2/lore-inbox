Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTFYSTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTFYSTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:19:37 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:42914 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264916AbTFYSTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:19:36 -0400
Date: Wed, 25 Jun 2003 20:33:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Must-fix] Keyboard occasionally endlessly repeating keys
Message-ID: <20030625183340.GD1770@wohnheim.fh-wedel.de>
References: <20030620202444.GD22732@wohnheim.fh-wedel.de> <1056495483.1027.260.camel@w-jstultz2.beaverton.ibm.com> <20030625090723.GA10864@wohnheim.fh-wedel.de> <1056563557.1033.278.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1056563557.1033.278.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 June 2003 10:52:37 -0700, john stultz wrote:
> On Wed, 2003-06-25 at 02:07, Jörn Engel wrote:
> > 
> > Should I still test w/ clock=pit?
> 
> Not if its resolved for you. I was just seeing a number of time related
> keyboard problems on laptops (kbd repeat rates too fast)and wanted to
> see if you were affected as well. 

Not resolved, but understood.  The hardware is broken, no doubt about
it.  2.5 should be able to deal with the broken hardware just as good
as 2.4 was, but Vojtech appears to be working on it.  Until then I
have to live with my problem. :(

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
