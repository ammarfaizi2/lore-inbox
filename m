Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVA0Xuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVA0Xuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVA0Xt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:49:59 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:54460 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261302AbVA0Xan convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:30:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Len Brown <len.brown@intel.com>
Subject: Re: [RFC: 2.6 patch] drivers/acpi/: possible cleanups
Date: Thu, 27 Jan 2005 18:30:35 -0500
User-Agent: KMail/1.7.2
Cc: Adrian Bunk <bunk@stusta.de>,
       Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>,
       Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <20050127110125.GE28047@stusta.de> <1106867060.2400.2297.camel@d845pe>
In-Reply-To: <1106867060.2400.2297.camel@d845pe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501271830.36444.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 18:04, Len Brown wrote:
> Thanks for the patch Adrian.
> 
> I agree that this is the right direction to go -- enforcing APIs with
> the use of static reduces the possibility of programming errors --
> particularly with many cooks in the kitchen.  Indeed, just on Monday we
> discussed a patch from Alexey Starikovskiy to do the same thing.
> 
> The problem is one of logistics.
> As I've described before, the files with "R. Byron Moore" at the top are
> dual-licensed so Intel can distribute the core interpreter both as GPL
> to Linux and also to FreeBSD, HP-UX etc


Well, I can not speak for Adrian but if I were to submit a patch and state
that it is also dual licensed you should have no troubles applying it even
to the core files, right?
  
-- 
Dmitry
