Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbUDFQS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUDFQS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:18:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25319 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263886AbUDFQSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:18:24 -0400
Date: Tue, 6 Apr 2004 17:18:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [RFC] filling in ACPI files in sysfs
Message-ID: <20040406161823.GF23258@parcelfarce.linux.theplanet.co.uk>
References: <1081266989.2375.35.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081266989.2375.35.camel@patsy.fc.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:56:30AM -0600, Alex Williamson wrote:
>    Seems like it's about time the ACPI sysfs namespace started doing
> more than looking pretty.  Here's a stab at adding in some basic
> functionality.  I'd like to get some feedback before I start filling in
> the more complicated features.  This has been lightly tested on a
> sampling of HP ia64 boxes.  Does this seem like a reasonable start? 
> Comments and reports from other platforms welcome.  Thanks,

This is something I've wanted for a long time!  Thanks for doing the
work, Alex.  I'll give it a try on my x86 crash-n-bash box.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
