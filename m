Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUGCDBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUGCDBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 23:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUGCDBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 23:01:06 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:52615 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265812AbUGCDBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 23:01:04 -0400
Date: Sat, 3 Jul 2004 13:00:22 +1000
From: Andrew Clausen <clausen@gnu.org>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, bug-parted@gnu.org,
       Thomas Fehr <fehr@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703030022.GD630@gnu.org>
References: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org> <s5gzn6iz2or.fsf@patl=users.sf.net> <Pine.LNX.4.60.0407022025200.28638@hermes-1.csi.cam.ac.uk> <s5gvfh6xklo.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gvfh6xklo.fsf@patl=users.sf.net>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 03:57:59PM -0400, Patrick J. LoPresti wrote:
> > It is not only not wrong but completely correct.  The geometry is
> > really something completely made up nowadays.  Nothing really needs
> > it at the low level.
> 
> Wrong.  The Windows boot loader still reads sectors using the legacy
> BIOS interface.  If not for this unfortunate fact, this entire issue
> would be moot.

Have you got any evidence?  Is there any way I can force Windows to
use CHS?

Cheers,
Andrew

