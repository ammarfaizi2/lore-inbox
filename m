Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUKCXTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUKCXTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUKCXR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:17:27 -0500
Received: from brown.brainfood.com ([146.82.138.61]:23168 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261890AbUKCXHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:07:10 -0500
Date: Wed, 3 Nov 2004 17:06:56 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Christoph Hellwig <hch@infradead.org>
cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <20041103211353.GA24084@infradead.org>
Message-ID: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Christoph Hellwig wrote:

> On Wed, Nov 03, 2004 at 04:02:49PM -0500, Timothy Miller wrote:
> > I'm just curious about why there seems to be so much work going into
> > supporting a wide range of GCC versions.  If people are willing to
> > download and compile a new kernel (and migrating from 2.4 to 2.6 is
> > non-trivial for some systems, like RH9), why aren't they willing to also
> > download and build a new compiler?
>
> Because the new compilers are a lot slower.

You can't be serious that this is a problem.
