Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUC3D3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 22:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUC3D3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 22:29:46 -0500
Received: from fmr06.intel.com ([134.134.136.7]:19411 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262131AbUC3D3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 22:29:44 -0500
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch
From: Len Brown <len.brown@intel.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Administrator@smtp.paston.co.uk, Andrew Morton <akpm@osdl.org>,
       Luming Yu <luming.yu@intel.com>,
       Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@intel.com>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6C72@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6C72@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080617358.980.30.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Mar 2004 22:29:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 10:46, Dax Kelson wrote:
> On Mon, 2004-01-05 at 19:59, Valdis.Kletnieks@vt.edu wrote:
> > On Mon, 05 Jan 2004 18:08:59 PST, Andrew Morton said:
> > 
> > > Thanks, the acpi-20031203 patch seems to have introduced a handful
> of
> > > regressions.
> > 
> > As suggested by Yu Luming, the patch at
> http://bugzilla.kernel.org/show_bug.cgi?id=1766
> > is confirmed to fix my issue.  2.6.1-rc1-mm2 with that patch gives
> me:
> 
> Just confirming that the same patched fixed up the battery reporting
> problems on my laptop as well.

While I'm happy that patches backported to 2.6.0 and 2.6.1
work properly, is is probably more valuable to the community
to know that the latest 2.6 release works -- particularly since
the fix in question was integrated into the baseline 6 weeks ago.

thanks,
-Len


