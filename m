Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbULURUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbULURUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbULURUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:20:52 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:12230 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261811AbULURUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:20:35 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Dan Dennedy <dan@dennedy.org>,
       Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041221171702.GE1459@kroah.com>
References: <20041220015320.GO21288@stusta.de>
	 <1103508610.3724.69.camel@kino.dennedy.org>
	 <20041220022503.GT21288@stusta.de>
	 <1103510535.1252.18.camel@krustophenia.net>
	 <1103516870.3724.103.camel@kino.dennedy.org>
	 <20041220225324.GY21288@stusta.de>
	 <1103583486.1252.102.camel@krustophenia.net>
	 <20041221171702.GE1459@kroah.com>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 12:20:32 -0500
Message-Id: <1103649633.9220.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 09:17 -0800, Greg KH wrote:
> On Mon, Dec 20, 2004 at 05:58:06PM -0500, Lee Revell wrote:
> > On Mon, 2004-12-20 at 23:53 +0100, Adrian Bunk wrote:
> > > The solution is simple:
> > > The vendor or services provider submits his driver for inclusion into 
> > > the kernel which is the best solution for everyone.
> > > 
> > 
> > What if the driver is under development and doesn't work yet?
> 
> Many drivers have been accepted into the kernel tree before they worked
> properly :)

Yeah but I hope you can understand why someone would be hesitant to
submit a broken driver.  It just makes the author look bad.  I would not
feel right submitting something that didn't work.

Lee

