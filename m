Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbUKPPrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUKPPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUKPPrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:47:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:3508 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262001AbUKPPrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 10:47:06 -0500
Date: Tue, 16 Nov 2004 07:46:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Fruhwirth Clemens <clemens@endorphin.org>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@redhat.com>
Subject: Re: GPL version, "at your option"?
In-Reply-To: <Pine.LNX.4.53.0411161547260.7946@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0411160746030.2222@ppc970.osdl.org>
References: <1100614115.16127.16.camel@ghanima>
 <Pine.LNX.4.53.0411161547260.7946@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Nov 2004, Tim Schmielau wrote:

> On Tue, 16 Nov 2004, Fruhwirth Clemens wrote:
> 
> > I'm about to submit a patch for a new cipher mode called LRW, adding new
> > code/files to the crypto tree. My question is, especially to the
> > maintainers: Are you going to accept code covered by the terms:
> > 
> >  * This program is free software; you can redistribute it and/or modify
> >  * it under the terms of the GNU General Public License as published by
> >  * the Free Software Foundation, version 2 of the License.
> 
> There are several occurences in the kernel already doing exactly that.

Indeed. See the main COPYING file for the whole kerrnel. So if you don't 
explicitly state otherwise, the kernel by _default_ is v2 only.

		Linus
