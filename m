Return-Path: <linux-kernel-owner+w=401wt.eu-S1422684AbWLUDpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWLUDpE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWLUDpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:45:03 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:1735 "EHLO
	HQEMGATE02.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422676AbWLUDpA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:45:00 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 22:45:00 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Date: Thu, 21 Dec 2006 11:39:52 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0E0A75C2@hkemmail01.nvidia.com>
In-Reply-To: <45898CC4.9010805@pobox.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Thread-Index: AcckcQSNHZLcJj57REyeGISZyrFM+gAQKTJQ
From: "Peer Chen" <pchen@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 21 Dec 2006 03:39:58.0120 (UTC) FILETIME=[AFD60A80:01C724B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. 


BRs
Peer Chen

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: Thursday, December 21, 2006 3:20 AM
To: Peer Chen
Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org; Andrew
Morton
Subject: Re: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to
ahci.c

Peer Chen wrote:
> Resend the patch.
> The content of memory map io of BAR5 have been change from MCP65 then
sata_nv can't work fine on the platform based on MCP65 and MCP67,so move
their IDs from sata_nv.c to ahci.c.
> Please check attachment for new patch,thanks.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Patch applied, manually.

For future patches,

1) Please do not quote the original message

2) Please include patches inline, rather than as an attachment.

	Jeff



-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
