Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUJLQFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUJLQFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJLQE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:04:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:10174 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266069AbUJLQDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:03:53 -0400
Date: Tue, 12 Oct 2004 09:03:12 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20041012160312.GA10837@kroah.com>
References: <16A54BF5D6E14E4D916CE26C9AD305754575A3@pdsmsx402.ccr.corp.intel.com> <Pine.LNX.4.58.0410100955120.3897@ppc970.osdl.org> <20041012125202.GA920@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012125202.GA920@zip.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 10:52:02PM +1000, CaT wrote:
> 
> So basically, something got fixed between rc3 and rc4. Personally, I
> call shenanigans.

Heh, no, Linus applied the patch to the tree for rc4, so you just proved
that the fix works for your box :)

thanks,

greg k-h
