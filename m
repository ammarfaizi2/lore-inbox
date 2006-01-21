Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWAUXaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWAUXaJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWAUXaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:30:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5796 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751224AbWAUXaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:30:08 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Lee Revell <rlrevell@joe-job.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601211826.02159.gene.heskett@verizon.net>
References: <20060119030251.GG19398@stusta.de>
	 <200601211826.02159.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 18:30:05 -0500
Message-Id: <1137886206.11722.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 18:26 -0500, Gene Heskett wrote:
> On Wednesday 18 January 2006 22:02, Adrian Bunk wrote:
> >Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
> 
> This thread has run on for a bit longer it seems, and it prompts me to 
> back up to the original post and ask if the raw driver you are removing 
> is the raw driver used when cups tells a device (a printer) to do this 
> file using the -o raw format?
> 
> If this is the case, then a rather large amount of printing 
> functionality will be removed as a side effect.  I hope I'm 
> miss-understanding the intent here.

No, it's a different raw driver, for big databases that basically want
their own custom filesystem on a disk.

Lee

