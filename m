Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbUDFXqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUDFXqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:46:02 -0400
Received: from [212.28.208.94] ([212.28.208.94]:37131 "HELO dewire.com")
	by vger.kernel.org with SMTP id S264071AbUDFXqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:46:00 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
Date: Wed, 7 Apr 2004 01:45:54 +0200
User-Agent: KMail/1.6.1
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Timothy Miller <miller@techsource.com>, root@chaos.analogic.com,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040406233257.84968.qmail@web40506.mail.yahoo.com>
In-Reply-To: <20040406233257.84968.qmail@web40506.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404070145.55368.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 April 2004 01:32, Sergiy Lozovsky wrote:
> --- viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Whether it's commonly-used or not, there's another
> > killer problem with LISP -
> > it's fragmented worse than even Pascal.
>
> Can I have more details? All LISPs I know manage
> memory by themselves as well as the one I use. They
> allocate memory pool, create a list of free cells in
> it and that's it. What is the problem? Yes, cells in
> the free list are not contiguous, it's a list.

Not memory fragmentation, language definition fragmentation. 
There is no language called "LISP" (except the original). There are several 
dozen strains with slighly or very different syntax, scope rules and other 
variations. LISP1.5, MacLisp, Emacs Lisp, AutoLisp, Common Lisp, Scheme to 
mention a very few of the more known species, and most of these come in 
different dialects. 

-- robin
