Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTFFS4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFFS4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:56:54 -0400
Received: from angband.namesys.com ([212.16.7.85]:62612 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262197AbTFFS4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:56:52 -0400
Date: Fri, 6 Jun 2003 23:10:25 +0400
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: short freezing while file re-creation
Message-ID: <20030606191025.GB7612@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030606091759.GC23608@namesys.com> <20030606172454.6f3cbeed.skraw@ithnet.com> <20030606160217.GE6455@namesys.com> <1054926053.23132.278.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054926053.23132.278.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 06, 2003 at 03:00:54PM -0400, Chris Mason wrote:

> There are still some latency issues with io in rc7, it could be a
> general problem.

Hm. But I think everything that was not needing disk io (i.e. mouse stuff)
should not be affected?

Bye,
    Oleg
