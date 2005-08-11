Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVHKVDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVHKVDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVHKVDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:03:21 -0400
Received: from emulex.emulex.com ([138.239.112.1]:6315 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S932357AbVHKVDU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:03:20 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: lpfc driver in 2.6.13-rc6 broken on ppc64 ?
Date: Thu, 11 Aug 2005 17:03:10 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F43C7@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: lpfc driver in 2.6.13-rc6 broken on ppc64 ?
Thread-Index: AcWer4zL6E5DgIzGSLagNpc7ILsWQgACBgaw
To: <sonny@burdell.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This signature is consistent with having out of date firmware on the adapter.

See http://www.emulex.com/ts/indexemu.html.  There are some hints on downloading firmware at the tail end of  http://sourceforge.net/forum/forum.php?thread_id=1130082&forum_id=355154. 

Thanks.

-- James S


> -----Original Message-----
> From: Sonny Rao [mailto:sonny@burdell.org]
> Sent: Thursday, August 11, 2005 4:00 PM
> To: Smart, James
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> Subject: lpfc driver in 2.6.13-rc6 broken on ppc64 ?
> 
> 
> Hi, I am having problems using some older Emulex fibre adapters on a
> ppc64 machine, whenever I load the lpfc driver I get a large 
> number of 
> 
> "lpfc 0001:d8:01.0: 1:0321 Unknown IOCB command Data: x0 x3 x0 x0"
> 
> with several hundred messages per adapter
> 
> and finally I get this message:
> 
> lpfc 0001:d8:01.0: 1:0222 Initial FLOGI timeout
> lpfc 0001:d8:01.0: 1:0127 ELS timeout Data: x4000000 xfffffe x8a x23
> 
> 
> Is this a known issue ?
> 
> Let me know if you need patches tested, thanks.
> 
> Sonny Rao
> IBM LTC Performance
> 
> 
> 
