Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUKHTLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUKHTLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUKHTJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:09:42 -0500
Received: from fmr06.intel.com ([134.134.136.7]:5587 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261955AbUKHRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:03:05 -0500
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
From: Len Brown <len.brown@intel.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Adrian Bunk <bunk@stusta.de>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <418D403E.30608@conectiva.com.br>
References: <20041105215021.GF1295@stusta.de>
	 <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de>
	 <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de>
	 <418D403E.30608@conectiva.com.br>
Content-Type: text/plain
Organization: 
Message-Id: <1099933263.13831.9547.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Nov 2004 12:01:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion.

I'd certainly accept patches using ACPI_FUTURE_USAGE and moving
EXPORT_KSYMS to where they're more easily tracked.

If the motivation is kernel static size reduction, then I'll be
interested in seeing a before/after kernel size measurements.

-Len


