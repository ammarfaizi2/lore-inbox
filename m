Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWAEDrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWAEDrr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWAEDrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:47:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15578 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751910AbWAEDrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:47:46 -0500
Date: Wed, 4 Jan 2006 22:47:38 -0500
From: Dave Jones <davej@redhat.com>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] acpi: Add list of IBM R40 laptops to processor_power dmi table.
Message-ID: <20060105034738.GF2658@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <0ISL00NX49551L@a34-mta01.direcway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ISL00NX49551L@a34-mta01.direcway.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 05:00:25PM -0500, Ben Collins wrote:
 > Signed-off-by: Ben Collins <bcollins@ubuntu.com>

There's a variant of this in -mm already, (albeit with horked indentation)
Does your diff have all the same entries that one does ?
(If so, I prefer yours :)

This is also being tracked at http://bugme.osdl.org/show_bug.cgi?id=3549
Len seemed to have an objection against merging this, but if every distro
is carrying it anyway, it seems kinda pointless not to imo.

		Dave

