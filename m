Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268992AbUIADjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268992AbUIADjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268994AbUIADjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:39:55 -0400
Received: from fmr10.intel.com ([192.55.52.30]:39617 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S268992AbUIADjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:39:53 -0400
Subject: Re: pnp and acpi_pnp
From: Len Brown <len.brown@intel.com>
To: castet.matthieu@free.fr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C46FD@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C46FD@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1094005570.3943.55.camel@linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Aug 2004 23:39:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu,
PNPBIOS should be disabled when ACPI is enabled, and it is a bug that
this is not automatic.

yes, the "Linux PNP" layer is incomplete, and ACPI isn't yet plugged
into that.

cheers,
-Len


