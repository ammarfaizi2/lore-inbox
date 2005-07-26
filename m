Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVGZTzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVGZTzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGZTzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:55:43 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:61574 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261960AbVGZTzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:55:40 -0400
To: Len Brown <len.brown@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
In-Reply-To: <1122407079.13241.4.camel@toshiba.lenb.intel.com>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com> <b6d0f5fb0505220425146d481a@mail.gmail.com> <1122407079.13241.4.camel@toshiba.lenb.intel.com>
Date: Tue, 26 Jul 2005 20:55:37 +0100
Message-Id: <E1DxVWb-0002Sx-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:

> I deleted /proc/acpi/button on purpose,
> did you have a use for those files?

There are various cases where it's useful to know whether a laptop is
shut or not, and /proc/acpi/button seems to be the only place where that
information is made available at the moment.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
