Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135178AbRDZIGU>; Thu, 26 Apr 2001 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRDZIGK>; Thu, 26 Apr 2001 04:06:10 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:34822 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135178AbRDZIGD>; Thu, 26 Apr 2001 04:06:03 -0400
Date: Thu, 26 Apr 2001 10:05:32 +0200
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Recent ACPI patch
Message-ID: <20010426100531.A2229@maggie.romantica.wg>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDCA@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDCA@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Wed, Apr 25, 2001 at 10:27:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 10:27:42AM -0700, Andrew Grover wrote:
> > From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> > Stephen Torri wrote:
> > > 
> > > I noticed that the big update patch for ACPI was a part of 
> > 2.4.3-ac11 (Can
> > > remember). Now its not a part of 2.4.3-ac12. Has it been 
> > removed? I have
> > > turned on experimental settings when running make xconfig.
> > 
> > Alan noted the update did not build, so it was removed.
> 
> Doh!
> 
> OK, I'm on it. ;-) BTW did ACPI in ac11 build for you?
I build fine here. IIRC one hunk of the patch was rejected.

It was the first ACPI kernel for my Asus A7V that did power off the
machine.

Jens

-- 
Jens Taprogge
