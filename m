Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752555AbVHGS6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbVHGS6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbVHGS6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:58:23 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:970 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1752555AbVHGS6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:58:23 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: christos gentsis <christos_gentsis@yahoo.co.uk>
Subject: Re: Logitech Quickcam Express USB Address Aquisition Issues
Date: Sun, 7 Aug 2005 19:58:22 +0100
User-Agent: KMail/1.8.1
Cc: Chris White <chriswhite@gentoo.org>, linux-kernel@vger.kernel.org
References: <20050807160222.0c4ee412@localhost> <1123414600.14724.3.camel@linux.site> <200508071954.10618.s0348365@sms.ed.ac.uk>
In-Reply-To: <200508071954.10618.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508071958.22477.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 Aug 2005 19:54, Alistair John Strachan wrote:
> On Sunday 07 Aug 2005 12:36, christos gentsis wrote:
> [snip]
>
> > > I searched up google a bit and recieved some warnings about acpi
> > > causing problems, so I disabled that, but was still unsucessful in
> > > getting that to work.  Please let me know if any other information is
> > > required. Thanks ahead of time.
> > >
> > > Chris White
> >
> > does the drivers for the Phillips web cams come back to the kernel?
> > because i thought that it was taken out...
> >
> > http://www.smcc.demon.nl/webcam/
> >
> > check this site and see if your cam was one of the cams that supported
> > from the driver that discontinue... so if is supported by this driver,
> > download and install it... it works i try it with my cam ;)
>
> The in-kernel pwc driver doesn't work for me either. I highly recommend you
> try the above if this turns out to not be a hardware fault.

Sorry, I didn't even check the link. Try the driver from:

http://www.saillard.org/linux/pwc/

Which seems to work better.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
