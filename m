Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWHRWtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWHRWtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWHRWtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:49:09 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:11789 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1751565AbWHRWtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:49:07 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: [PATCH] [NET] [TG3] Convert the pci_device_it table to
 PCI_DEVICE()
From: "Michael Chan" <mchan@broadcom.com>
To: "Henne" <henne@nachtwindheim.de>
cc: akpm@osdl.org, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44E195B2.3070406@nachtwindheim.de>
References: <44E195B2.3070406@nachtwindheim.de>
Date: Fri, 18 Aug 2006 15:48:41 -0700
Message-ID: <1155941321.4201.1.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006081809; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34344536343245452E303033412D412D;
 ENG=IBF; TS=20060818224900; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006081809_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68F89C51388269946-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 11:36 +0200, Henne wrote:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Convert the pci_device_ids to PCI_DEVICE() macro.
> Saves 1.5k in the sourcefile.
> 
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> ---

Acked-by: Michael Chan <mchan@broadcom.com>


