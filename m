Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbTAQQjK>; Fri, 17 Jan 2003 11:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267588AbTAQQjK>; Fri, 17 Jan 2003 11:39:10 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:63499 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S267571AbTAQQjJ>; Fri, 17 Jan 2003 11:39:09 -0500
Date: Fri, 17 Jan 2003 16:47:37 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: Jason Radford <jradford@iconimaging.net>
cc: szepe@pinerecords.com, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
 Promise ctrlr, or...
In-Reply-To: <20021221172247.179b1478.jradford@iconimaging.net>
Message-ID: <Pine.LNX.4.44.0301171645540.1415-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2002, Jason Radford wrote:

> If IDE raid unix linux is needed here, there's no question that a
> linux supported (thanks adam) 3ware card is dropped in, no questions
> asked.  For my 3 years of working with them under linux THEY JUST
> WORK.  Native monitoring tools included too..

or get an outboard RAID box that uses IDE disks and SCSI for its
connection to the host. plenty of them around if you google. (eg
fibrenetix.co.uk - we have one, and works nicely. reasonably fast
too.)

> -Jason

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

