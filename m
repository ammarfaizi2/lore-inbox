Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTFFTHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTFFTHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:07:39 -0400
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:17313 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262220AbTFFTHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:07:38 -0400
Subject: Re: short freezing while file re-creation
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030606191025.GB7612@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	 <2804790000.1052441142@aslan.scsiguy.com>
	 <20030509120648.1e0af0c8.skraw@ithnet.com>
	 <20030509120659.GA15754@alpha.home.local>
	 <20030509150207.3ff9cd64.skraw@ithnet.com>
	 <20030606091759.GC23608@namesys.com>
	 <20030606172454.6f3cbeed.skraw@ithnet.com>
	 <20030606160217.GE6455@namesys.com>
	 <1054926053.23132.278.camel@tiny.suse.com>
	 <20030606191025.GB7612@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054927256.23130.288.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Jun 2003 15:20:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 15:10, Oleg Drokin wrote:
> Hello!
> 
> On Fri, Jun 06, 2003 at 03:00:54PM -0400, Chris Mason wrote:
> 
> > There are still some latency issues with io in rc7, it could be a
> > general problem.
> 
> Hm. But I think everything that was not needing disk io (i.e. mouse stuff)
> should not be affected?
> 

It shouldn't ;-)  But the problems are still not completely understood. 
This particular problem could still be reiserfs, it's hard to say right
now.

-chris

