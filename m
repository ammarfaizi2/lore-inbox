Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSJIKNt>; Wed, 9 Oct 2002 06:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSJIKNt>; Wed, 9 Oct 2002 06:13:49 -0400
Received: from 210-54-175-12.visp.co.nz ([210.54.175.12]:4626 "EHLO
	mdew.dyndns.org") by vger.kernel.org with ESMTP id <S261518AbSJIKNs>;
	Wed, 9 Oct 2002 06:13:48 -0400
Subject: Re: [Jfs-discussion] maximum filesystem size limit
From: mdew <mdew@mdew.dyndns.org>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Cameron Bahar <CBahar@s8.com>,
       "'jfs-discussion@www-124.ibm.com'" 
	<jfs-discussion@www-124.southbury.usf.ibm.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
In-Reply-To: <200210091153.59452.roy@karlsbakk.net>
References: <8D587D949A61D411AFE300D0B74D75D703F0BF1B@server.s8.com> 
	<200210091153.59452.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 23:19:21 +1300
Message-Id: <1034158761.5865.1.camel@mdew>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 22:53, Roy Sigurd Karlsbakk wrote:
> On Tuesday 08 October 2002 23:14, Cameron Bahar wrote:
> > I need support for a single 12 TB filesystem on Linux. The documentation
> > indicates that JFS supports a theoretical 4PB limit, but that other
> > limitations (32 bit offsets) within limit prevent scaling to this large
> > size.
> >
> > Can someone please tell me if I can use JFS to create a single 12TB
> > filesystem under Linux?
> 
> Afaik, you have a problem here concerning the Linux 2.4 maximum block device 
> size of 2TB.

is this "fixed" in 2.5 yet?


