Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbSJIQVb>; Wed, 9 Oct 2002 12:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbSJIQVb>; Wed, 9 Oct 2002 12:21:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:523
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S261840AbSJIQVa>; Wed, 9 Oct 2002 12:21:30 -0400
Date: Wed, 9 Oct 2002 09:27:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: mdew <mdew@mdew.dyndns.org>, Cameron Bahar <CBahar@s8.com>,
       "'jfs-discussion@www-124.ibm.com'" 
	<jfs-discussion@www-124.southbury.usf.ibm.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: [Jfs-discussion] maximum filesystem size limit
Message-ID: <20021009162707.GB1148@matchmail.com>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	mdew <mdew@mdew.dyndns.org>, Cameron Bahar <CBahar@s8.com>,
	"'jfs-discussion@www-124.ibm.com'" <jfs-discussion@www-124.southbury.usf.ibm.com>,
	Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-raid@vger.kernel.org
References: <8D587D949A61D411AFE300D0B74D75D703F0BF1B@server.s8.com> <200210091153.59452.roy@karlsbakk.net> <1034158761.5865.1.camel@mdew> <200210091225.24185.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210091225.24185.roy@karlsbakk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 12:25:24PM +0200, Roy Sigurd Karlsbakk wrote:
> > > > Can someone please tell me if I can use JFS to create a single 12TB
> > > > filesystem under Linux?
> > >
> > > Afaik, you have a problem here concerning the Linux 2.4 maximum block
> > > device size of 2TB.
> >
> > is this "fixed" in 2.5 yet?
> 
> I beleive so

No, not Linus 2.5.  It is in Andrew Morton's -mm tree though.  That should
mean that after some heavy pounding on the code (what else would you expect
from akpm?) it will probably be in 2.5-linus soon...
