Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRBNSGJ>; Wed, 14 Feb 2001 13:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRBNSF6>; Wed, 14 Feb 2001 13:05:58 -0500
Received: from ike-ext.ab.videon.ca ([206.75.216.35]:45959 "HELO
	ike-ext.ab.videon.ca") by vger.kernel.org with SMTP
	id <S129623AbRBNSFm>; Wed, 14 Feb 2001 13:05:42 -0500
Date: Wed, 14 Feb 2001 11:23:04 -0700
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: "ASN Stevens, Computing Service" <Alastair.Stevens@bristol.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-ac12 compile failure on sparc64
Message-ID: <20010214112304.C22741@lovelife.olvc.ab.ca>
In-Reply-To: <EXECMAIL.1010214113238.Y@velifer.bris.ac.uk> <20010214224148.C2132@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010214224148.C2132@linuxcare.com>; from anton@linuxcare.com.au on Wed, Feb 14, 2001 at 10:41:48PM +1100
From: Anthony Fok <foka@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 10:41:48PM +1100, Anton Blanchard wrote:
> > Hi - I am having compilation troubles on my sparc64 workstation (standard 
> > Ultra 5 machine), which is currently running stock 2.4.1 on Red Hat 6.2 quite 
> > happily.
> 
> We arent tracking the -ac patches at the moment and alan can't be expected
> to ensure it compiles on all architectures. Best bet is to stick with
> Linus releases.

You are right, of course, but then ASN Stephens is also right for reporting
a problem in the -ac patches.  Or do you expect people to ignore bugs in the
-ac series and let bugs go unreported?  How will the -ac series improve, and
ultimately, how will the official Linux kernel improve?

Granted, in this case, Alan already knew the problem.  :-)

Cheers,

Anthony

-- 
Anthony Fok Tung-Ling                Civil and Environmental Engineering
foka@ualberta.ca, foka@debian.org    University of Alberta, Canada
   Debian GNU/Linux Chinese Project -- http://www.debian.org/intl/zh/
Come visit Our Lady of Victory Camp -- http://www.olvc.ab.ca/

