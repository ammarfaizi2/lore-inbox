Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTEGGBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTEGGBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:01:10 -0400
Received: from [66.186.193.1] ([66.186.193.1]:40709 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id S262811AbTEGGBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:01:09 -0400
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 64.122.104.99
X-Authenticated-Timestamp: 02:18:29(EDT) on May 07, 2003
X-HELO-From: [10.134.0.76]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 64.122.104.99
Subject: Re: [Bug 466] New: SBP2 driver doesn't appear to register a block
	device?
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bcollins@debian.org
In-Reply-To: <200303180430.h2I4UMW20016@bugme.osdl.org>
References: <200303180430.h2I4UMW20016@bugme.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052287896.1784.7.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 23:11:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I originally submitted this bug report.  It's fixed in 2.5.69.

Thanks!

Torrey Hoffman
thoffman@arnor.net

On Mon, 2003-03-17 at 20:30, bugme-daemon@osdl.org wrote:
> http://bugme.osdl.org/show_bug.cgi?id=466
> 
>            Summary: SBP2 driver doesn't appear to register a block device?
>     Kernel Version: 2.5.65
>             Status: NEW
>           Severity: normal
>              Owner: bcollins@debian.org
>          Submitter: thoffman@arnor.net
> 
> 
> Distribution: Red Hat 8.0
> Hardware Environment: Single Processor Pentium III, details below
> Software Environment: 
> Problem Description: Loading ieee1394 SBP2 driver doesn't result in a usable
> block device appearing.


