Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWAEFeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWAEFeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWAEFeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:34:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17309 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751942AbWAEFeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:34:10 -0500
Date: Thu, 5 Jan 2006 00:34:00 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bcollins@ubuntu.com, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH 07/15] acpi: Add list of IBM R40 laptops to processor_power dmi table.
Message-ID: <20060105053400.GB20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, bcollins@ubuntu.com,
	linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
	acpi-devel@lists.sourceforge.net
References: <0ISL00NX49551L@a34-mta01.direcway.com> <20060105034738.GF2658@redhat.com> <20060104212751.1670e058.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104212751.1670e058.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 09:27:51PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Wed, Jan 04, 2006 at 05:00:25PM -0500, Ben Collins wrote:
 > >  > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
 > > 
 > > There's a variant of this in -mm already, (albeit with horked indentation)
 > > Does your diff have all the same entries that one does ?
 > > (If so, I prefer yours :)
 > 
 > Below.

Ok. The IDs seem to be the same. I'd vote to drop the -mm one and
go with Ben's variant which fixes the lindent trainwreck at the same time.

		Dave
