Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVGaHoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVGaHoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 03:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVGaHoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 03:44:44 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:57781 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261738AbVGaHon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 03:44:43 -0400
Date: Sun, 31 Jul 2005 08:44:34 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S3 resume and PNP (was: Re: S3 resume and serial console..)
In-Reply-To: <20050731080859.A5580@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0507310835320.20476@skynet>
References: <Pine.LNX.4.58.0507300301370.13092@skynet>
 <20050730085558.A7770@flint.arm.linux.org.uk> <21d7e99705073017295ed29c64@mail.gmail.com>
 <20050731080859.A5580@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > And as I said its an i865 based motherboard from Intel... nothing
> > special on it, do you need to know the super-io chip, i.e. I 'll have
> > to open the case to find out...
>
> The above two messages tells me you're probably using plug'n'play.
> Unfortunately, for some unknown reason, the Linux plug'n'play
> subsystem does not support suspend/resume.  This is not a serial
> problem.
>

Okay I've disabled PnP in my kernel, now I get nothing back from the
serial port on resume... not sure if that is an improvement or not :-)

I'll keep messing about with it and see what I can work out...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

