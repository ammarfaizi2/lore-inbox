Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTEFSkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTEFSkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:40:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8321
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264022AbTEFSkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:40:39 -0400
Subject: Re: [patch/2.5.69] zoran driver update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Ronald Bultje <R.S.Bultje@pharm.uu.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mjpeg-developer@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>,
       Frank Davis <fdavis@si.rr.com>
In-Reply-To: <20030506182257.GA2043@kroah.com>
References: <1052234524.2482.70.camel@shrek.bitfreak.net>
	 <20030506182257.GA2043@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052243658.1202.48.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 18:54:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 19:22, Greg KH wrote:
> On Tue, May 06, 2003 at 05:22:05PM +0200, Ronald Bultje wrote:
> > Hi Linus/all,
> > 
> > http://mjpeg.sourceforge.net/driver-zoran/linux-zoran-driver.patch.gz
> > contains a patch that updates the current zoran driver (v4l/v4l2 driver
> > for zr36057/zr36067-based MJPEG cards) in kernel 2.5.x to the newest
> > stable version that we have. Patch is against 2.5.69.
> 
> Please go read Documentation/SubmittingPatches for why just sending a
> link will not work :)
> 
> Gerd, want to pick up these patches?

Someone also needs to make sure the merge keeps all the security fixes
from the old driver.

