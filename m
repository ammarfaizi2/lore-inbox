Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbTLaXFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbTLaXFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:05:17 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:11496 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265274AbTLaXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:05:13 -0500
Subject: Re: udev and devfs - The final word
From: Rob Love <rml@ximian.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Nathan Conrad <lk@bungled.net>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>
	 <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>
	 <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur>
	 <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1072911903.11003.27.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 31 Dec 2003 18:05:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 17:55, viro@parcelfarce.linux.theplanet.co.uk
wrote:

> I think you've missed a point here.  There are several places where kernel
> deals with device identification.

I know all of this.  I was trying to explain how Unix VFS understands
devices (via major/minor number, not filename).  Different audience.

	Rob Love


