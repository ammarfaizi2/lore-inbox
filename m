Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVCNLAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVCNLAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVCNLAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:00:38 -0500
Received: from webapps.arcom.com ([194.200.159.168]:7175 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262112AbVCNLAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:00:35 -0500
Message-ID: <42356ED0.5040603@cantab.net>
Date: Mon, 14 Mar 2005 11:00:32 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: long <tlnguyen@snoqualmie.dp.intel.com>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com, tom.l.nguyen@intel.com
Subject: Re: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
References: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com>
In-Reply-To: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2005 11:06:32.0921 (UTC) FILETIME=[E183F490:01C52885]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

long wrote:
> This patch includes PCIEAER-HOWTO.txt, which describes how the PCI
> Express Advanced Error Reporting Root driver works.

> --- linux-2.6.11-rc5/Documentation/PCIEAER-HOWTO.txt

Could this be placed in a sub-system subdirectory (creating one if
necessary, e.g., pci/)?  The root of Documentation/ is rather full of
random files as is.

David Vrabel
