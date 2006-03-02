Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWCBD0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWCBD0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWCBD0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:26:21 -0500
Received: from xenotime.net ([66.160.160.81]:47594 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750901AbWCBD0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:26:18 -0500
Date: Wed, 1 Mar 2006 19:27:40 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: libata queue contents
Message-Id: <20060301192740.1172e579.rdunlap@xenotime.net>
In-Reply-To: <44063E09.1060303@rtr.ca>
References: <20060301203901.GA6915@havoc.gtf.org>
	<44063E09.1060303@rtr.ca>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2006 19:36:25 -0500 Mark Lord wrote:

> Jeff Garzik wrote:
> > Here's the stuff that's pending for 2.6.17, in the
> > libata-dev.git#upstream branch.  These changes are also auto-propagated
> > to Andrew Morton's -mm via the #ALL meta-branch.
> 
> Where are Randy's ACPI patches ?

I haven't generated them against #upstream.  I'll try to do that
in the next couple of days (assuming that I can git along with git).
or can I use the git-rollup patch in -mm to diff against?

---
~Randy
