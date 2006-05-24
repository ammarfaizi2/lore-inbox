Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWEXUip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWEXUip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWEXUip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:38:45 -0400
Received: from mga03.intel.com ([143.182.124.21]:65300 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932373AbWEXUio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:38:44 -0400
X-IronPort-AV: i="4.05,169,1146466800"; 
   d="scan'208"; a="41133791:sNHT14827466549"
Subject: Re: [-mm] oops during boot, in dock-related code
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060523083908.GA1604@elf.ucw.cz>
References: <20060523083908.GA1604@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 24 May 2006 13:49:18 -0700
Message-Id: <1148503759.28890.2.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 24 May 2006 20:37:59.0839 (UTC) FILETIME=[F23772F0:01C67F71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 10:39 +0200, Pavel Machek wrote:
> Hi!
> 
> I'll try to turn off CONFIG_ACPI_DOCK to see if it helps... yes it
> does.
> 									Pavel

Hi Pavel,
I must have missed part of this thread... can you give me some more
details?  A config, log messages, or some way to reproduce?  Did you
boot in the dock, or outside of the dock?  I tried to just boot the
latest -mm with CONFIG_ACPI_DOCK set to y, and was unable to cause an
oops.  

Thanks,
Kristen
