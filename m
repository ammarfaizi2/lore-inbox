Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266285AbUARJBX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 04:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266300AbUARJBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 04:01:23 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:22926 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S266285AbUARJBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 04:01:22 -0500
From: Andrew Walrond <andrew@walrond.org>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: ACPI: problem on ASUS PR-DLS533
Date: Sun, 18 Jan 2004 09:01:20 +0000
User-Agent: KMail/1.5.4
References: <3ACA40606221794F80A5670F0AF15F8401720CE8@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CE8@PDSMSX403.ccr.corp.intel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401180901.20662.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 Jan 2004 4:18 am, Yu, Luming wrote:
> > unfortunately neither 2.4.23 or 2.4.24 will boot from the
> > Mylex 170 Raid card
> > (DAC960) with ACPI enabled, so I never get to lspci :(
>
> Are you sure, you can verify it with acpi=off.
>

Yes, I'm sure. I's running the same kernel fine with pci=noacpi

