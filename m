Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTIDBjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTIDBjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:39:09 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41227
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264460AbTIDBjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:39:06 -0400
Date: Wed, 3 Sep 2003 18:39:21 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ian Kumlien <pomac@vapor.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>,
       Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: [SHED] Questions.
Message-ID: <20030904013921.GJ16361@matchmail.com>
Mail-Followup-To: Ian Kumlien <pomac@vapor.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Con Kolivas <kernel@kolivas.org>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
	Robert Love <rml@tech9.net>
References: <1062324435.9959.56.camel@big.pomac.com> <200309011707.20135.phillips@arcor.de> <1062457396.9959.243.camel@big.pomac.com> <200309021023.24763.kernel@kolivas.org> <1062498307.5171.267.camel@big.pomac.com> <3F547A4B.7060309@cyberone.com.au> <1062523374.5171.321.camel@big.pomac.com> <3F552C70.2030109@cyberone.com.au> <1062630148.9959.680.camel@big.pomac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062630148.9959.680.camel@big.pomac.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:02:29AM +0200, Ian Kumlien wrote:
> On Wed, 2003-09-03 at 01:49, Nick Piggin wrote:
> > Ian Kumlien wrote:
> > >And not the amount of cpu consumed by the app / go?
> 
> > Well yeah in a way. Consuming CPU lowers priority, sleeping raises.
> 
> Thought so. And afair it does use "timeslice useage" at one time or has
> that changed?

I think that's part of the interactivity estimator Nick removed in his
patches...
