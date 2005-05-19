Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVESMDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVESMDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVESMDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:03:23 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:58538 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262355AbVESMDT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:03:19 -0400
X-IronPort-AV: i="3.93,120,1115010000"; 
   d="scan'208"; a="262978650:sNHT79080528"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Date: Thu, 19 May 2005 07:03:17 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED382@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Thread-Index: AcVcIrYy481zkvJsQjGsl5DHS0ZzuQAR269g
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <Matt_Domsch@Dell.com>,
       <adobriyan@gmail.com>
X-OriginalArrivalTime: 19 May 2005 12:03:17.0916 (UTC) FILETIME=[BE5075C0:01C55C6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, May 18, 2005 10:33 PM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; Andrew Morton; Domsch, Matt; Alexey
> Dobriyan
> Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
Dell
> BIOS update driver
> 
> On Wed, May 18, 2005 at 01:13:42PM -0500, Abhay Salunke wrote:
> > This is a resubmit of the patch after incorporating all the inputs
> > from revieweres. This also has a fix where the packets were leaked
in
> > the function create_packet line#227.
> 
> You did not address the issues I had with your use of binary sysfs
files
> for all file types.  Please fix that up.
> 
> Also, what's wrong with using the existing firmware interface in the
> kernel?
> 
I am working on it; just wanted to address all the cosmetic issues
first.

Thanks,
Abhay 

