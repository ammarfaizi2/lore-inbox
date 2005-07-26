Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVGZMZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVGZMZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVGZMZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:25:20 -0400
Received: from pop.gmx.de ([213.165.64.20]:5071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261730AbVGZMZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:25:18 -0400
X-Authenticated: #26200865
Message-ID: <42E62BB0.6010409@gmx.net>
Date: Tue, 26 Jul 2005 14:25:20 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ACPI] Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (2/2)
References: <200507261247.05684.rjw@sisk.pl> <200507261254.05507.rjw@sisk.pl>
In-Reply-To: <200507261254.05507.rjw@sisk.pl>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki schrieb:
> The following patch adds basic suspend/resume support to the sk98lin
> network driver.
[snipped]

The current in-kernel sk98lin driver is years behind the version
downloadable from Syskonnect. Maybe it would make sense to update
it first before applying any new patches.
http://www.syskonnect.com/support/driver/d0102_driver.html

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
