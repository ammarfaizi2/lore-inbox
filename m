Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbUKPOjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUKPOjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUKPOhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:37:35 -0500
Received: from users.linvision.com ([62.58.92.114]:129 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261967AbUKPOfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:35:48 -0500
Date: Tue, 16 Nov 2004 15:35:46 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: GPL version, "at your option"?
Message-ID: <20041116143546.GA4398@harddisk-recovery.com>
References: <1100614115.16127.16.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100614115.16127.16.camel@ghanima>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 03:08:35PM +0100, Fruhwirth Clemens wrote:
> I'm about to submit a patch for a new cipher mode called LRW, adding new
> code/files to the crypto tree. My question is, especially to the
> maintainers: Are you going to accept code covered by the terms:
> 
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation, version 2 of the License.

There's already quite some code that's only licensed with GPLv2. Look
for example at arch/arm/common/dmabounce.c which does the same as you
want but with slightly different words:

 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  version 2 as published by the Free Software Foundation.

If you are the author, you can choose the license you like.


Erik (IANAL, etc.)

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
