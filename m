Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWEaNTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWEaNTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWEaNTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:19:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52135 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751384AbWEaNTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:19:19 -0400
Date: Wed, 31 May 2006 08:43:34 -0400
From: Raphael Assenat <raph@raphnet.net>
Subject: Re: [PATCH] Add max6902 RTC support
In-reply-to: <20060530235500.edc9ef49.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Campbell <ijc@hellion.org.uk>, alessandro.zummo@towertech.it,
       linux-kernel@vger.kernel.org
Message-id: <20060531124333.GA945@aramis.lan.raphnet.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060530150913.GE797@aramis.lan.raphnet.net>
 <20060530203241.4a4de734@inspiron>
 <20060530184949.GF797@aramis.lan.raphnet.net>
 <20060530150143.7e39dac3.akpm@osdl.org>
 <1149057131.7461.40.camel@localhost.localdomain>
 <20060530235500.edc9ef49.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 11:55:00PM -0700, Andrew Morton wrote:
> Ian Campbell <ijc@hellion.org.uk> wrote:
> > On Tue, 2006-05-30 at 15:01 -0700, Andrew Morton wrote:
...
> >         (a) The contribution was created in whole or in part by me and I
> >         have the right to submit it under the open source license
> >         indicated in the file; or
> >         
> >         (b) The contribution is based upon previous work that, to the
> >         best of my knowledge, is covered under an appropriate open
> >         source license and I have the right under that license to submit
> >         that work with modifications, whether created in whole or in
> >         part by me, under the same open source license (unless I am
> >         permitted to submit under a different license), as indicated in
> >         the file; or
> 
> Yes, I think that would work, if Rafael is prepared to make that assertion.
> 
> If so, please send along a few words describing where the Compulab code
> came from and some substantiation of your belief that it was appropriately
> licensed.  (It probably had some license words at the top of the file..)
The compulab code comes from the kernel patch the produce for their
cn-x255 board. (inside a zip file on the 
http://www.compulab.co.il/x255/html/x255-developer.htm)

The original file (drivers/char/max6902.c) was GPL, which is of course
an appropriate licence:

/*
 * max6902.c
 *
 * Driver for MAX6902 RTC
 *
 * Copyright (C) 2004 Compulab Ltd.
 *
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 *
 */

For reference, you can get the original file here:
http://raph.people.8d.com/misc/max6902.c

Regards,
Raphael Assenat

