Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbTHVVE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbTHVVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:04:26 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52750
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261679AbTHVVEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:04:21 -0400
Date: Fri, 22 Aug 2003 14:04:18 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Wiktor Wodecki <wodecki@gmx.net>
Cc: insecure <insecure@mail.od.ua>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18int
Message-ID: <20030822210418.GJ1040@matchmail.com>
Mail-Followup-To: Wiktor Wodecki <wodecki@gmx.net>,
	insecure <insecure@mail.od.ua>, linux-kernel@vger.kernel.org
References: <200308222231.25059.kernel@kolivas.org> <20030822134136.GA711@gmx.de> <20030822175352.GH1040@matchmail.com> <200308222335.50318.insecure@mail.od.ua> <20030822204433.GF710@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822204433.GF710@gmx.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 10:44:33PM +0200, Wiktor Wodecki wrote:
> On Fri, Aug 22, 2003 at 11:35:50PM +0300, insecure wrote:
> > On Friday 22 August 2003 20:53, Mike Fedyk wrote:
> > > On Fri, Aug 22, 2003 at 03:41:37PM +0200, Wiktor Wodecki wrote:
> > > > 15:38:55  cpu %usr %sys %nice %idle pswch/s runq nrproc lavg1 lavg5 avg15
> > > > _cpu_ 15:38:56  all   26    9     0    66    1730    3    115 11.58  7.87
> > > > 3.44 15:38:57  all    8    4     0    88    1137    1    115 11.58  7.87
> > > > 3.44 15:38:58  all   10    4     0    86    1204    1    115 11.58  7.87
> > > > 3.44 15:38:59  all    6    5     0    89    1002    1    115 11.58  7.87
> > > > 3.44 15:39:00  all    5    4     0    91    1219    1    115 11.58  7.87
> > > > 3.44 15:39:01  all    9    4     0    87    1748    1    115 11.69  7.95
> > > > 3.49
> > >
> > > What nice little utility is this from?
> > 
> > I'm curious too ;)
> > I palyed a bit with a similar toy. Attached.
> > Want to see other's source.
> 
> before more people email me, it's vmstat(8)

Unfortunately, the procps fork is getting even bigger now... :(

I don't see an option for this in debian's package. 
