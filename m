Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVBQXSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVBQXSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBQXQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:16:40 -0500
Received: from fmr16.intel.com ([192.55.52.70]:19364 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261225AbVBQXOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:14:19 -0500
Subject: Re: [ACPI] Call for help: list of machines with working S3
From: Len Brown <len.brown@intel.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
In-Reply-To: <20050217101533.GA15721@ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <1108621005.2096.412.camel@d845pe>  <20050217101533.GA15721@ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1108681977.2096.507.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Feb 2005 18:12:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 05:15, Vojtech Pavlik wrote:

> I'm not sure if you can push the whole industry at once.

The goal is to know what to tell the system vendors
interested in supporting Linux what they should do
with their BIOS on future platforms.

I believe our message should be:
1. BIOS should save/restore video in S3
2. Use Intel's ACPICA ASL compiler -- if not for production,
then at least as a static source code checker for validation.

thanks,
-Len


