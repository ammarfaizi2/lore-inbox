Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWGLVMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWGLVMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGLVMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:12:52 -0400
Received: from [212.33.163.77] ([212.33.163.77]:30468 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932330AbWGLVMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:12:52 -0400
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Thu, 13 Jul 2006 00:13:30 +0300
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200607112257.22069.a1426z@gawab.com> <200607122312.19909.a1426z@gawab.com> <1152736028.3217.74.camel@laptopd505.fenrus.org>
In-Reply-To: <1152736028.3217.74.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607130013.30731.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-07-12 at 23:12 +0300, Al Boldi wrote:
> > It already checks for it, but makes no difference.
> >
> > Thanks for looking into this!
>
> well glibc also randomizes things a bit (for better cache coloring) ...

Any way to turn it off?

Thanks!

--
Al

