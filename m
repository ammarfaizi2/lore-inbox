Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266818AbUBMIOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 03:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUBMIOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 03:14:50 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:1664 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266818AbUBMIMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 03:12:53 -0500
Date: Fri, 13 Feb 2004 09:13:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ping Cheng <pingc@wacom.com>, linux-kernel@vger.kernel.org
Subject: Re: Wacom USB driver patch
Message-ID: <20040213081326.GB247@ucw.cz>
References: <28E6D16EC4CCD71196610060CF213AEB065BCA@wacom-nt2.wacom.com> <20040212192809.3c7e6db4.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212192809.3c7e6db4.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 07:28:09PM -0800, Pete Zaitcev wrote:
> On Thu, 12 Feb 2004 16:55:47 -0800
> Ping Cheng <pingc@wacom.com> wrote:
> 
> > The wacom.c at http://linux.bkbits.net:8080/linux-2.4 is way out of date and
> > people are still working on/using 2.4 releases. Should I make a patch for
> > 2.4?
> 
> We plan to support 2.4 based releases for several years yet. If Vojtech
> approves what you did for 2.6, I am all for a backport to Marcelo tree.
> Marcelo is not very forthcoming with approvals these days, but perhaps
> it may be folded into some update. But as usual I would like to avoid
> carrying a patch in Red Hat tree, if at all possible.

Agreed. Same for us at SUSE.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
