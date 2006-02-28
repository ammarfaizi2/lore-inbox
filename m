Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWB1LtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWB1LtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWB1LtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:49:02 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49115 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751533AbWB1LtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:49:00 -0500
Date: Tue, 28 Feb 2006 12:46:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH 4/13] ATA ACPI: add params/docs.
Message-ID: <20060228114647.GA4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135403.55086107.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222135403.55086107.randy_d_dunlap@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add and use 'noacpi' parameter for libata-acpi.

Why is this option needed? Either the code works, or it does not. If
it does not, it is not suitable for merging...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
