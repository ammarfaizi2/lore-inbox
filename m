Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTGWQqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbTGWQqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:46:03 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56076
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270438AbTGWQqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:46:01 -0400
Date: Wed, 23 Jul 2003 10:01:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: different behaviour with badblocks on 2.6.0-test1-mm1-07int
Message-ID: <20030723170107.GH1176@matchmail.com>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <20030722214253.GD1176@matchmail.com> <20030723081844.GB1324@home.woodlands> <200307231324.h6NDO5qj009710@turing-police.cc.vt.edu> <20030723151950.GA2218@home.woodlands>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723151950.GA2218@home.woodlands>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 08:49:50PM +0530, Apurva Mehta wrote:
> * Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> [2003-07-23 19:55]:
> > On Wed, 23 Jul 2003 13:48:44 +0530, Apurva Mehta <apurva@gmx.net>  said:
> > 
> > > On 2.6.0-test1, gkrellm does not show any disk usage at all for
> > > me. The disk usage krell just remains blank. vmstat reports expected
> > > usage though.
> > 
> > Upgrade your gkrellm - 2.1.14 is current.
> > 
> > 2.1.6 Wed Jan 22, 2003
> > ...
> >         * Patches:
> >           o Andreas Boman <aboman--at--eiwaz.com> had two Linux patches:
> > ...
> >             - implemented reading disk stats from sysfs for recent 2.5.x kernels.
> 
> I am using 2.1.14.. Still no luck with it reading disks.. 

Maybe you need to mount sysfs on /sys?
