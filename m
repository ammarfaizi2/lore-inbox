Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265426AbUGGUkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbUGGUkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUGGUkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:40:00 -0400
Received: from fmr10.intel.com ([192.55.52.30]:55486 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S265426AbUGGUj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:39:59 -0400
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
From: Len Brown <len.brown@intel.com>
To: Volker Braun <volker.braun@physik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FF6DB@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FF6DB@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089232778.15671.473.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Jul 2004 16:39:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 10:14, Volker Braun wrote:
> ACPI S3 draws too much power on the T40/T41, this has been confirmed
> by
> various people (so its not just mine). Suspended it lasts about 10h,
> about twice as long as powered up. Supposed to be 1-2 weeks. 
> 
> I guess we should have filed a bug report a long time ago. I'll do
> that
> now.
> 
> If anybody has any tips on how to debug this (debug a suspended
> machine :-) I would like to know.

I think it will take an SDV with an instrumented power supply
to tell us exactly where the power is going.

-Len


