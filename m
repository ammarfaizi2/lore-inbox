Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131776AbRCOSVB>; Thu, 15 Mar 2001 13:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131777AbRCOSUv>; Thu, 15 Mar 2001 13:20:51 -0500
Received: from styx.suse.cz ([213.210.157.162]:8699 "EHLO inspiron.random")
	by vger.kernel.org with ESMTP id <S131776AbRCOSUi>;
	Thu, 15 Mar 2001 13:20:38 -0500
Date: Thu, 15 Mar 2001 19:19:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich.Weigand@de.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.2 update_vm_cache_conditional?
Message-ID: <20010315191924.B24333@inspiron.suse.cz>
In-Reply-To: <C1256A0F.0061EC62.00@d12mta11.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1256A0F.0061EC62.00@d12mta11.de.ibm.com>; from Ulrich.Weigand@de.ibm.com on Wed, Mar 14, 2001 at 06:49:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 06:49:33PM +0100, Ulrich.Weigand@de.ibm.com wrote:
> that manifests itself only on S/390:

I guess it could trigger also on sparc.

> Do you agree that this is a bug?  What do you think of this fix:

That's a severe bug, fix is obviously right.

Andrea
