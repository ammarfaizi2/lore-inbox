Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263939AbUECXt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUECXt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUECXt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:49:59 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:37433 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S263939AbUECXt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:49:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
Date: Mon, 3 May 2004 18:49:55 -0500
Message-ID: <0960978B185D2848BF5BBAE1BFB343E104E424@ausx2kmps315.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
Thread-Index: AcQxZ9weZ1R+jtB8QjOwIKYy0UeQDwAAVsZg
From: <Michael_E_Brown@Dell.com>
To: <marcelo.tosatti@cyclades.com>, <mebrown@michaels-house.net>
Cc: <linux-kernel@vger.kernel.org>, <viro@parcelfarce.linux.theplanet.co.uk>
X-OriginalArrivalTime: 03 May 2004 23:49:56.0356 (UTC) FILETIME=[565E3C40:01C43169]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, Greg KH has pushed it into current -mm, and intends to push it up
for 2.6.7.
--
Michael

> -----Original Message-----
> From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
> Sent: Monday, May 03, 2004 6:40 PM
> To: Michael Brown
> Cc: linux-kernel@vger.kernel.org; Brown, Michael E; 
> viro@parcelfarce.linux.theplanet.co.uk
> Subject: Re: [PATCH 2.4] add SMBIOS information to 
> /proc/smbios -- UPDATED
> 
> 
> On Thu, Apr 29, 2004 at 09:21:52PM -0500, Michael Brown wrote:
> > Marcelo, Al,
> > 	Below is an updated patch to add SMBIOS information to 
> /proc/smbios.
> > Updates have been made per Al's previous comments. Please apply.
> > 
> > For reference, here are previous postings:
> > Previous 2.4 thread:
> > http://marc.theaimsgroup.com/?t=108321757100001&r=1&w=1
> > 
> > Previous 2.6 thread:
> > http://marc.theaimsgroup.com/?t=108311959700002&r=1&w=1
> 
> Hi Michael,
> 
> Has your patch been accepted into v2.6? 
> 
