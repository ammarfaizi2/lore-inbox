Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTJRUww (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTJRUww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:52:52 -0400
Received: from 72.dom-sp.ru ([212.57.164.72]:17672 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S261820AbTJRUwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:52:51 -0400
Date: Sun, 19 Oct 2003 02:52:34 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] Compile error in 2.4.22 without PCI
Message-ID: <20031019025234.A26563@natasha.ward.six>
References: <20031015003036.A10226@natasha.ward.six> <20031017133301.B27349@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017133301.B27349@infradead.org>; from hch@infradead.org on Fri, Oct 17, 2003 at 01:33:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 01:33:01PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 15, 2003 at 12:30:36AM +0600, Denis Zaitsev wrote:
> > I have these warnings when I'm compiling 2.4.22 for a 486 EISA system:
> > 
> > The patch below fixes this.  And the same patch fits for the 2.6
> > kernels.  Please, apply it.
> 
> You probably want to send this to Justin, the driver Maintainer.  If he
> doesn't reply in say a week I?d suggest submitting it to Marcelo as it's
> obviously correct.

Thanks for the reply.  I've already tried exactly the same sequence
some weeks ago... :)  Anyway, I'll do this again right now.  Thanks.
