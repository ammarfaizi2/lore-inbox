Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbTLISRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbTLISRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:17:54 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:54791 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S266040AbTLISRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:17:45 -0500
Date: Tue, 9 Dec 2003 19:17:39 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Matthew Reppert <repp0017@tc.umn.edu>
Cc: <linux-kernel@vger.kernel.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [OOPS] 2.6.0-test11 sysfs
In-Reply-To: <1070992648.27231.7.camel@minerva>
Message-ID: <Pine.LNX.4.33.0312091914310.1130-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Matthew Reppert wrote:

> Try this patch. (Patrick, is this the sane thing to do? And is it worth
> it? If so, I can do similar things to the other sysfs_create_* functions
> if you would like.)

Thanks, willl, try it and report back tomorrow. Meanwhile, I created the
mount point and added a record to fstab... And then I've got it again...
Will it also be addressed with your patch? Funny - with directory but
without the record in fstab (so, sysfs not mounted) it doesn't oops...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany


