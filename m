Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWCUC6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWCUC6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 21:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWCUC6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 21:58:36 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:39326 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751290AbWCUC6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 21:58:35 -0500
Message-ID: <9FCDBA58F226D911B202000BDBAD4673054C3676@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Lindent and coding style
Date: Tue, 21 Mar 2006 10:58:31 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Monday, March 20, 2006 10:37 PM
> To: Li Yang-r58472
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Lindent and coding style
> 
> On Llu, 2006-03-20 at 19:32 +0800, Li Yang-r58472 wrote:
> > There is a lindent script in linux kernel source.  It breaks long
> > lines, but uses space instead of tab as indentation.  However, the
> > codingstyle document also from the kernel source indicates no space is
> > allowed for indentation.  Is there a fix for this problem?  Or the
> > result from lindent(space indentation) is actually allowed in kernel
> > source?  Thanks.
> >
> 
> It should produce suitable output. Do you have examples of where it
> produces space indentation and you expect tabs ?
One more thing to add, my indent is GNU indent 2.2.9 coming with Redhat 9.0.  Does it matter?
