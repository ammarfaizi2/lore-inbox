Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUCAJ3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUCAJ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:29:09 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:7120 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261156AbUCAJ3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:29:00 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Date: Mon, 1 Mar 2004 14:58:46 +0530
User-Agent: KMail/1.5
References: <20040227212301.GC1052@smtp.west.cox.net>
In-Reply-To: <20040227212301.GC1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011458.46287.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like this. Can you also do the same change for x86_64 before checking in?

We need to review Kconfig help sometime, as George has pointed out in another 
email.

-Amit

On Saturday 28 Feb 2004 2:53 am, Tom Rini wrote:
> Hello.  The following patch moves all of the config options into one file,
> kernel/Kconfig.kgdb.
> <snip>


