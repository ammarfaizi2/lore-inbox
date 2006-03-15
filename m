Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWCOMbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWCOMbS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWCOMbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:31:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42209 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750785AbWCOMbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:31:17 -0500
Subject: Re: Patch 2/9] Initialization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: nagar@watson.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1142418273.3021.10.camel@laptopd505.fenrus.org>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297101.5858.10.camel@elinux04.optonline.net>
	 <1142418273.3021.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 12:37:36 +0000
Message-Id: <1142426256.5597.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-15 at 11:24 +0100, Arjan van de Ven wrote:
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of version 2.1 of the GNU Lesser General Public License
> > + * as published by the Free Software Foundation.
> > + *
> 
> LGPL inside the kernel doesn't make a whole lot of sense.... better make
> it GPL.

When you combine an LGPL and GPL work you get a GPL work so yes it would
be clearer to mark it GPL as that is what it became as it was merged,
but perhaps to add a note stating where it can be obtained under other
licenses for other projects.


