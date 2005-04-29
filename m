Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVD2SQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVD2SQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVD2SQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:16:56 -0400
Received: from emulex.emulex.com ([138.239.112.1]:13193 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S262862AbVD2SQn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:16:43 -0400
From: James.Smart@Emulex.Com
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Emulex fibre channel HBA support and SAN connection
Date: Fri, 29 Apr 2005 14:16:32 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C2062982@xbl3.ad.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Emulex fibre channel HBA support and SAN connection
Thread-Index: AcVM527Ytq0QG+VfSU2hvn9IP6qvqQAABmIw
To: <hch@infradead.org>
Cc: <alexdeucher@gmail.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We'll look into it...

-- james

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Friday, April 29, 2005 2:15 PM
> To: Smart, James
> Cc: alexdeucher@gmail.com; linux-kernel@vger.kernel.org;
> linux-scsi@vger.kernel.org
> Subject: Re: Emulex fibre channel HBA support and SAN connection
> 
> 
> On Fri, Apr 29, 2005 at 02:08:01PM -0400, 
> James.Smart@Emulex.Com wrote:
> > We are putting together such a document that will be placed
> > out on SourceForge.
> 
> My idea was to put in in the driver actually, so that the 
> ->probe routine
> can print an error message for the user.
> 
> 
