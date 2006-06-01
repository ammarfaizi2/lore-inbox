Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965299AbWFATIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbWFATIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWFATIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:08:31 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:57069 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S965297AbWFATIa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:08:30 -0400
X-ASG-Debug-ID: 1149188908-14254-0-2
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-ASG-Orig-Subj: RE: pci_enable_msix throws up error
Subject: RE: pci_enable_msix throws up error
Date: Thu, 1 Jun 2006 15:08:41 -0400
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD777C0648@nekter>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pci_enable_msix throws up error
Thread-Index: AcaFrssVqQDbXTogTHmQKfeELiVA+Q==
From: "Ravinandan Arakali" <Ravinandan.Arakali@neterion.com>
To: "Andi Kleen" <ak@suse.de>, "Ayaz Abdulla" <AAbdulla@nvidia.com>
Cc: "Ravinandan Arakali" <Ravinandan.Arakali@neterion.com>,
       <linux-kernel@vger.kernel.org>,
       "Ananda. Raju" <ananda.raju@neterion.com>, <netdev@vger.kernel.org>,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have submitted a proposed fix for the below issue.
Will wait for comments.

Ravi

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Friday, May 05, 2006 1:44 AM
To: Ayaz Abdulla
Cc: ravinandan.arakali@neterion.com; linux-kernel@vger.kernel.org;
Ananda. Raju; netdev@vger.kernel.org; Leonid Grossman
Subject: Re: pci_enable_msix throws up error


On Friday 05 May 2006 07:14, Ayaz Abdulla wrote:
> I noticed the same behaviour, i.e. can not use both MSI and MSIX without
> rebooting.
> 
> I had sent a message to the maintainer of the MSI/MSIX source a few
> months ago and got a response that they were working on fixing it. Not
> sure what the progress is on it.

The best way to make progress faster would be for someone like you
who needs it to submit a patch to fix it then.

-Andi

