Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbUBDJmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 04:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266226AbUBDJmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 04:42:31 -0500
Received: from ns.suse.de ([195.135.220.2]:30869 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266160AbUBDJm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 04:42:28 -0500
Date: Wed, 4 Feb 2004 10:39:17 +0100
From: Karsten Keil <kkeil@suse.de>
To: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc3 with isdn patch + devfs doesn't compile
Message-ID: <20040204093917.GA17433@pingi3.kke.suse.de>
Mail-Followup-To: isdn4linux@listserv.isdn4linux.de,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <401E4A80.4050907@web.de> <20040202195139.GB2534@pingi3.kke.suse.de> <20040204073812.GR4443@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204073812.GR4443@fs.tum.de>
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 08:38:12AM +0100, Adrian Bunk wrote:
> On Mon, Feb 02, 2004 at 08:51:39PM +0100, Karsten Keil wrote:
> > On Mon, Feb 02, 2004 at 02:02:56PM +0100, Todor Todorov wrote:
> > > Hello everyone,
> > > 
> > > didn't find any more applicabale mailing list, so here it goes:
> > > 
> > 
> > try the actual I4L for 2.6 patch in 
> > ftp://ftp.isdn4linux.de/pub/isdn4linux/kernel/v2.6
> 
> FYI:
> I'm getting the following compile error in 2.6.2-rc3 with this patch 
> applied and CONFIG_DEVFS_FS=n:
> 

Thank you.
Next version of the  patch will remove devfs support from I4L for 2.6
kernel versions.

-- 
Karsten Keil
SuSE Labs
ISDN development
