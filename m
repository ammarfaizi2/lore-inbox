Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTEFESD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTEFESD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:18:03 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59408
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262348AbTEFESC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:18:02 -0400
Date: Mon, 5 May 2003 21:30:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Athanasius <link@miggy.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030506043026.GF8350@matchmail.com>
Mail-Followup-To: Athanasius <link@miggy.org>,
	Bill Davidsen <davidsen@tmr.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030423164015.GJ25981@miggy.org> <Pine.LNX.3.96.1030424174457.11734G-101000@gatekeeper.tmr.com> <20030425203017.GA16910@miggy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030425203017.GA16910@miggy.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 09:30:17PM +0100, Athanasius wrote:
> On Fri, Apr 25, 2003 at 12:17:43PM -0400, Bill Davidsen wrote:
> > I dont think this is a fix, it's a work-around. It shouldn't be
> > documnented, it should be made to work. That might mean having the kbuild
> > prevent inappropriate use, of course.
> 
>   Agreed, I more meant it needs documenting so that those people that
> hit it can apply the workaround and otherwise test the kernels.  I guess
> for now those of us that know about it will just have to keep an eye out
> for others reporting the problem then clue them in.

It's probably better this way.  If people don't know the work around, then
it will probably be reported again.  And the more it's reported with
successive versions the more corner cases will be found and fixed.

Documentation for work-arounds are meant for a proprietary world, and are
counter productive for open source.
