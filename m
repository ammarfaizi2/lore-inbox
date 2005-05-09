Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVEINBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVEINBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVEINBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:01:12 -0400
Received: from firewall.miltope.com ([208.12.184.221]:38971 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261341AbVEINBK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:01:10 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Announce] sg3_utils-1.14 available
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Mon, 9 May 2005 08:01:38 -0500
Message-ID: <66F9227F7417874C8DB3CEB05772741712AC36@MILEX0.Miltope.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Announce] sg3_utils-1.14 available
Thread-Index: AcVSnztPIWgj4hTGTJCqcJDw4jMJoQB980cg
From: "Drew Winstel" <DWinstel@Miltope.com>
To: <dougg@torque.net>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug,
> No. sg_rmsn issues a READ MEDIA SERIAL NUMBER SCSI command.
> This command (opcode 0xab, service action 1) was added in
> SPC-3 revision 11 (12th February 2003) and is not marked as
> mandatory. If supported, this command yields a "free format"
> media serial number. I have not seen any SCSI device that
> supports it (but being in SPC-3 all device types, especially
> those with removable media, could support it).

Ahh... Note to self: ingest caffeine, THEN read mailing list!

Thanks for the information.

Drew
