Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWAEFq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWAEFq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWAEFq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:46:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751957AbWAEFq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:46:56 -0500
Date: Wed, 4 Jan 2006 21:46:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: bcollins@ubuntu.com, linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH 07/15] acpi: Add list of IBM R40 laptops to
 processor_power dmi table.
Message-Id: <20060104214630.68b0c984.akpm@osdl.org>
In-Reply-To: <20060105053400.GB20809@redhat.com>
References: <0ISL00NX49551L@a34-mta01.direcway.com>
	<20060105034738.GF2658@redhat.com>
	<20060104212751.1670e058.akpm@osdl.org>
	<20060105053400.GB20809@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Jan 04, 2006 at 09:27:51PM -0800, Andrew Morton wrote:
>  > Dave Jones <davej@redhat.com> wrote:
>  > >
>  > > On Wed, Jan 04, 2006 at 05:00:25PM -0500, Ben Collins wrote:
>  > >  > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>  > > 
>  > > There's a variant of this in -mm already, (albeit with horked indentation)
>  > > Does your diff have all the same entries that one does ?
>  > > (If so, I prefer yours :)
>  > 
>  > Below.
> 
> Ok. The IDs seem to be the same. I'd vote to drop the -mm one and
> go with Ben's variant which fixes the lindent trainwreck at the same time.
> 

OK.  But I'll keep the attributions as I had them, under the assumption
that they're more accurate than Ben's (which appear to be not at all ;))

