Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbTFDUSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbTFDUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:18:22 -0400
Received: from catfish.lcs.mit.edu ([18.111.0.152]:5357 "EHLO
	catfish.lcs.mit.edu") by vger.kernel.org with ESMTP id S264041AbTFDUSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:18:21 -0400
Date: Wed, 4 Jun 2003 16:30:47 -0400 (EDT)
From: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
Subject: RE: sleep forever in ACPI mode S3
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F24@orsmsx401.jf.intel.com>
Message-ID: <Pine.GSO.4.10.10306041627070.2442-100000@catfish.lcs.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Grover, Andrew wrote:

> > echo 3 > /proc/acpi/sleep
> >  appears to work correctly on my IBM Thinkpad X20 -- except that it's
> >  impossible to wake the machine back up.
[...]
> Does it start to come back but then not make it, or is it just
> unrevivifiable?

hard to tell, since the screen is off.  nothing i do has any *visible*
effect on the machine.

> In any case, sleep/resume is a work in progress that won't work reliably
                                 ^^^^^^^^^^^^^^^^
> in the near-term.

hence my question.  is there anything i can do to help track down what's
happening?  cf:

> > Is this a known problem?  What keypresses are *supposed* to wake the
> > machine?  I looked through the code, but it looks like we 
> > punt off to the
> > ACPI firmware to do the actual sleep -- can anyone enlighten me on the
> > intended mechanism behind 'wake-from-sleep'?
  --scott

direct action LA DES Flintlock Soviet  Albanian colonel milita insurgent 
Ft. Meade RNC anthrax Rule Psix Saddam Hussein Uzi Minister Diplomat 
                         ( http://cscott.net/ )

