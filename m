Return-Path: <linux-kernel-owner+w=401wt.eu-S1751194AbXAFH4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXAFH4J (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbXAFH4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:56:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3931 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751194AbXAFH4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:56:06 -0500
Date: Sat, 6 Jan 2007 07:55:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI bay - 2.6.20-rc3-mm1 hangs on boot
Message-ID: <20070106075555.GA5660@ucw.cz>
References: <Pine.LNX.4.64.0701051351200.16747@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701051351200.16747@twin.jikos.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2007-01-05 14:19:41, Jiri Kosina wrote:
> Hi,
> 
> 2.6.20-rc3-mm1 hangs on boot on my IBM T42p when compiled with ACPI_BAY=y. 
> Below is the trace of two BUGs I get.
> 
> When compiled with ACPI_BAY=n, it boots fine.

ACPI people usually prefer entries in bugzilla.kernel.org, try that if
you don't get a timely reply.

-- 
Thanks for all the (sleeping) penguins.
