Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbUJKXci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbUJKXci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269342AbUJKXch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:32:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:51414 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269320AbUJKXak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:30:40 -0400
Date: Mon, 11 Oct 2004 16:34:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
Message-Id: <20041011163431.073f9bae.akpm@osdl.org>
In-Reply-To: <1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com>
	<20041011214304.GD31731@wotan.suse.de>
	<1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
	<20041011221519.GA11702@wotan.suse.de>
	<20041011153830.495b7c2d.akpm@osdl.org>
	<1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > I'd be suspecting no-buddy-bitmap-patch-*.patch
> > 
> 
> Nope. This is not it..

.config, please...
