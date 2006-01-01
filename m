Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWAAMOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWAAMOY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 07:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWAAMOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 07:14:24 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:18110 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751342AbWAAMOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 07:14:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/4] ACPI C-States policy update [Was: [PATCH] i386 No Idle HZ aka dynticks 051228]
Date: Sun, 1 Jan 2006 23:13:20 +1100
User-Agent: KMail/1.9
Cc: len.brown@intel.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org
References: <200512281718.14897.kernel@kolivas.org> <20051231110955.GA9123@dominikbrodowski.de>
In-Reply-To: <20051231110955.GA9123@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601012313.21704.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 December 2005 22:09, Dominik Brodowski wrote:
> Con, regarding your dyn-tick patches: please remove the two patches from
> your patchset which touch drivers/acpi/processor_idle.c and
> include/acpi/processor.h, and replace them with these updated versions.

Done; uploaded v060101 dynticks with just this change.

Cheers,
Con
