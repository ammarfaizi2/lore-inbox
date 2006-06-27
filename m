Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWF0UI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWF0UI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWF0UI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:08:57 -0400
Received: from pat.uio.no ([129.240.10.4]:10670 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932562AbWF0UI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:08:56 -0400
Subject: Re: [patch] fix static linking of NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Brownell <david-b@pacbell.net>
Cc: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606271259.16408.david-b@pacbell.net>
References: <yq04py7j699.fsf@jaguar.mkp.net> <44A1809F.5030306@sgi.com>
	 <200606271221.31927.david-b@pacbell.net>
	 <200606271259.16408.david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 16:08:40 -0400
Message-Id: <1151438920.23773.69.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.84, required 12,
	autolearn=disabled, AWL 1.16, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 12:59 -0700, David Brownell wrote:
> On Tuesday 27 June 2006 12:21 pm, David Brownell wrote:
> > OK here's a version of my patch that I edited to remove the
> > comments Jes objected to ... /* init or exit */ to remind
> > about the omitted section annotation.  Having one of those
> > would save multiple kbytes throughout the kernel, and I had
> > include the comments as reminders for an eventual fix...
> > 
> > - Dave
> > 
> 
> 
> Once more, with patch.

Acked...

Cheers,
  Trond

