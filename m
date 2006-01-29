Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWA2FEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWA2FEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 00:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWA2FEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 00:04:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:49618 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750829AbWA2FEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 00:04:43 -0500
Date: Sat, 28 Jan 2006 21:04:12 -0800
From: Paul Jackson <pj@sgi.com>
To: "Bob Picco" <bob.picco@hp.com>
Cc: y-goto@jp.fujitsu.com, akpm@osdl.org, apw@shadowen.org, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com, ak@suse.de,
       len.brown@intel.com, discuss@x86-64.org
Subject: Re: [PATCH 001/003]Fix unify mapping from pxm to node id.
Message-Id: <20060128210412.0c050675.pj@sgi.com>
In-Reply-To: <20060129034434.GO7306@localhost>
References: <20060123165644.C147.Y-GOTO@jp.fujitsu.com>
	<20060126074846.1a6dd300.pj@sgi.com>
	<20060128122758.CF50.Y-GOTO@jp.fujitsu.com>
	<20060127231517.4c0ce573.pj@sgi.com>
	<20060129034434.GO7306@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob wrote:
> MAX_PXM_DOMAINS is defined in include/acpi/acpi_numa.h.  So I'm confused.

Ah - there it is.  My mistake.

I did not realize that the list set of 3 patches was in addition
to, rather than replacing the previous patches.

I am retesting my build now -- I should be able to report
success in a few hours.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
