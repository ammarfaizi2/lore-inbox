Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWIFUDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWIFUDP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWIFUDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:03:15 -0400
Received: from xenotime.net ([66.160.160.81]:1224 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751533AbWIFUDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:03:14 -0400
Date: Wed, 6 Sep 2006 13:06:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@namei.org>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Generic infrastructure for acls
Message-Id: <20060906130647.7c415043.rdunlap@xenotime.net>
In-Reply-To: <200609061840.12707.agruen@suse.de>
References: <20060901221421.968954146@winden.suse.de>
	<20060901221457.803728153@winden.suse.de>
	<20060901144423.aa306d36.akpm@osdl.org>
	<200609061840.12707.agruen@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006 18:40:12 +0200 Andreas Gruenbacher wrote:

> On Friday, 01 September 2006 23:44, Andrew Morton wrote:
> > That's a clumsy-looking interface.
> 
> I have added a little documentation now. This will hopefully suffice to 
> clarify why the interface is as clumsy-looking as it is ;)

oops.  A bit difficult to comment on the patch.
Anyway, for the kernel-doc function headers (Thanks),
all of the parameters need to be listed, not just the first
one (@ops).

---
~Randy
