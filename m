Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbTEFSIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTEFSIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:08:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49916 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263901AbTEFSIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:08:51 -0400
Date: Tue, 6 May 2003 11:22:57 -0700
From: Greg KH <greg@kroah.com>
To: Ronald Bultje <R.S.Bultje@pharm.uu.nl>
Cc: linux-kernel@vger.kernel.org, mjpeg-developer@lists.sourceforge.net,
       Gerd Knorr <kraxel@bytesex.org>, Frank Davis <fdavis@si.rr.com>
Subject: Re: [patch/2.5.69] zoran driver update
Message-ID: <20030506182257.GA2043@kroah.com>
References: <1052234524.2482.70.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052234524.2482.70.camel@shrek.bitfreak.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 05:22:05PM +0200, Ronald Bultje wrote:
> Hi Linus/all,
> 
> http://mjpeg.sourceforge.net/driver-zoran/linux-zoran-driver.patch.gz
> contains a patch that updates the current zoran driver (v4l/v4l2 driver
> for zr36057/zr36067-based MJPEG cards) in kernel 2.5.x to the newest
> stable version that we have. Patch is against 2.5.69.

Please go read Documentation/SubmittingPatches for why just sending a
link will not work :)

Gerd, want to pick up these patches?

thanks,

greg k-h
