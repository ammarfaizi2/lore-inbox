Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWB1Lt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWB1Lt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWB1Ltz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:49:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49124 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750882AbWB1Lty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:49:54 -0500
Date: Tue, 28 Feb 2006 12:47:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH 5/13] ATA ACPI: use debugging macros
Message-ID: <20060228114733.GB4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135542.33fe242c.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222135542.33fe242c.randy_d_dunlap@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 22-02-06 13:55:42, Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add more libata-acpi debugging, plus controlled by libata.printk
> value.

Please don't. Instead select messages so that it is not too noisy by
default...
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
