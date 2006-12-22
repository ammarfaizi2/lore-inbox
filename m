Return-Path: <linux-kernel-owner+w=401wt.eu-S1752609AbWLVSEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbWLVSEh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 13:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWLVSEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 13:04:37 -0500
Received: from mga03.intel.com ([143.182.124.21]:1573 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbWLVSEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 13:04:36 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,205,1165219200"; 
   d="scan'208"; a="161636756:sNHT19182142"
Date: Fri, 22 Dec 2006 10:03:50 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] acpi: Remove procfs from bay
Message-Id: <20061222100350.09c3299b.kristen.c.accardi@intel.com>
In-Reply-To: <20061222114355.GB4268@ucw.cz>
References: <20061216223309.365745735@localhost.localdomain>
	<20061216144027.9765bdd1.kristen.c.accardi@intel.com>
	<20061222114355.GB4268@ucw.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 11:43:55 +0000
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > Remove the procfs related code from the bay driver.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> This changes userland interface... how many apps will it break?
> 
> 							Pavel
> 
> -- 
> Thanks for all the (sleeping) penguins.
> 

None - this code was never upstream - always just in -mm.

Kristen
