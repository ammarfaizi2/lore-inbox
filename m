Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUAFXfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUAFXfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:35:18 -0500
Received: from unogate.unocal.com ([192.94.3.1]:63440 "EHLO unogate.unocal.com")
	by vger.kernel.org with ESMTP id S265401AbUAFXfJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:35:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [autofs] [RFC] Towards a Modern Autofs
Date: Tue, 6 Jan 2004 17:34:08 -0600
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6BE7@slexch2.sugarland.unocal.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [autofs] [RFC] Towards a Modern Autofs
Thread-Index: AcPUp4GE367WqaZWQ/CBr8KhSB9ecQABRftA
From: "Ogden, Aaron A." <aogden@unocal.com>
To: "Tim Hockin" <thockin@hockin.org>
Cc: <thockin@Sun.COM>, "H. Peter Anvin" <hpa@zytor.com>,
       "autofs mailing list" <autofs@linux.kernel.org>,
       "Mike Waychison" <Michael.Waychison@Sun.COM>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2004 23:34:11.0302 (UTC) FILETIME=[9653F060:01C3D4AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Tim Hockin [mailto:thockin@hockin.org] 
> Sent: Tuesday, January 06, 2004 4:48 PM
> To: Ogden, Aaron A.
> Cc: thockin@Sun.COM; H. Peter Anvin; autofs mailing list; 
> Mike Waychison; Kernel Mailing List
> Subject: Re: [autofs] [RFC] Towards a Modern Autofs
> 
> 
> On Tue, Jan 06, 2004 at 04:28:59PM -0600, Ogden, Aaron A. wrote:
> > Solaris there is a command called 'automount' that tells the kernel
to
> > re-read the automount maps, perhaps it resets the autofs subsystem
in
> > the kernel as well.  If linux autofs had the same capability we
might
> > not need the daemon, but until then, having the daemon in userland
is a
> > good thing.
> 
> That's more or less exactly what is proposed.
> 

Excellent!  I haven't read through the proposal yet but I have it open
in another window.  :-)
The detailed proposal you've written implies that Sun as a whole has
given serious thought to the problem, which IMHO is how to make linux
autofs work like Solaris autofs.  Is Sun willing to devote man-hours to
help implement the new autofs?  I think Ian has done a tremendous job
with autofs4 but the more minds we throw at the problem the better.
