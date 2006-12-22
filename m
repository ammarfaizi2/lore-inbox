Return-Path: <linux-kernel-owner+w=401wt.eu-S1752461AbWLVLoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbWLVLoM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 06:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbWLVLoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 06:44:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4062 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752461AbWLVLoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 06:44:11 -0500
Date: Fri, 22 Dec 2006 11:43:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] acpi: Remove procfs from bay
Message-ID: <20061222114355.GB4268@ucw.cz>
References: <20061216223309.365745735@localhost.localdomain> <20061216144027.9765bdd1.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216144027.9765bdd1.kristen.c.accardi@intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Remove the procfs related code from the bay driver.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

This changes userland interface... how many apps will it break?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
