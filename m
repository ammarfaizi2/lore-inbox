Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVCHDDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVCHDDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVCHC7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:59:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:43919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261316AbVCHC43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:56:29 -0500
Date: Mon, 7 Mar 2005 15:45:00 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm1
Message-ID: <20050307234500.GA9374@kroah.com>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <1110185497.8407.4.camel@frecb000711.frec.bull.fr> <20050307005840.4a877d0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307005840.4a877d0c.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 12:58:40AM -0800, Andrew Morton wrote:
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> > I don't see the connector module [cn.ko] in this new release. Do you
> > remove it from your tree definitely?
> > 
> 
> I was pulling it in via one of Greg's trees.  I don't know why he dropped
> it.
> 
> Maybe it was my fault ;) I mentioned to Greg the other day that I had some
> concerns with the implementation and meant to give it a close review, but I
> haven't got onto it yet.

It's my fault, I restructured my trees to send the i2c only patches off
to Linus.  I'll rebuild it with the connector patches back in in a day
or so.

Sorry if this caused any problems.

greg k-h
