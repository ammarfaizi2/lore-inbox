Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVDFX2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVDFX2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVDFX2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:28:20 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:60103 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262353AbVDFX2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:28:15 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
Date: Wed, 6 Apr 2005 16:28:05 -0700
User-Agent: KMail/1.7.1
Cc: Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
References: <20050405204449.5ab0cdea@jack.colino.net> <200504061311.53720.david-b@pacbell.net> <1112828577.9568.199.camel@gaston>
In-Reply-To: <1112828577.9568.199.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061628.05527.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 4:02 pm, Benjamin Herrenschmidt wrote:
> 
> > Thanks for the testing update.  I'm glad to know that there seems to
> > be only one (minor) glitch that's PPC-specific!
> 
> Which is just an off-the-shelves NEC EHCI chip.

The wakeup-after-suspend hasn't been reported by anyone else.
