Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbSI3PgB>; Mon, 30 Sep 2002 11:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262108AbSI3PgB>; Mon, 30 Sep 2002 11:36:01 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:36764 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S262080AbSI3Pf7>; Mon, 30 Sep 2002 11:35:59 -0400
Subject: Re: Hard lockups running X with 2.5.38-bk4, -bk5 and -mm3
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D939062.9C44B2B8@digeo.com>
References: <1033078474.1306.43.camel@spc9.esa.lanl.gov> 
	<3D939062.9C44B2B8@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Sep 2002 09:37:03 -0600
Message-Id: <1033400223.1306.48.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 16:55, Andrew Morton wrote:
> Steven Cole wrote:
> > 
> > I only recently started testing 2.5.x kernels with X, and have
> > immediately run into problems.
[snipped]
> Me too.  deadlocks on tasklist_lock.  Some fixes went into Linus's
> tree a few hours ago, so please retest.

Sorry for the long delay (long weekend), but 2.5.39 works fine now with
X on my new test system.  Thanks.

Steven

