Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVD2SIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVD2SIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVD2SIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:08:18 -0400
Received: from emulex.emulex.com ([138.239.112.1]:13704 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S262863AbVD2SIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:08:14 -0400
From: James.Smart@Emulex.Com
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Emulex fibre channel HBA support and SAN connection
Date: Fri, 29 Apr 2005 14:08:01 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C2062981@xbl3.ad.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Emulex fibre channel HBA support and SAN connection
Thread-Index: AcVMsIhAYIUDcMMyQkCN0qYbRS8oqQANb8mw
To: <hch@infradead.org>
Cc: <alexdeucher@gmail.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are putting together such a document that will be placed
out on SourceForge.

-- james s


> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Friday, April 29, 2005 7:42 AM
> To: Smart, James
> Cc: alexdeucher@gmail.com; linux-kernel@vger.kernel.org;
> linux-scsi@vger.kernel.org
> Subject: Re: Emulex fibre channel HBA support and SAN connection
> 
> 
> On Fri, Apr 29, 2005 at 07:37:01AM -0400, 
> James.Smart@Emulex.Com wrote:
> > Based on the "Unknown IOCB command data" message, this 
> appears to be out of date firmware on the adapter. See 
> http://www.emulex.com/ts/indexemu.html.  There are some hints 
> on downloading firmware at the tail end of  
> http://sourceforge.net/forum/forum.php?thread_id=1130082&forum
> _id=355154. 
> 
> I've seeb quite a bit of these old firmware problems, maybe 
> lpfc should
> have a table of minimum required firmware versions for each HBA type?
> 
> 
