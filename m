Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbVHEU2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbVHEU2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVHEU2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:28:18 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:37145 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263172AbVHEU1x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:27:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kIPyffJU2aLwQ+L97xKXug6rjE7EUXOWKv05pkPPzplVRAwZi/VOPcYjPPlQbX3ovgDW1kCWb2t+kssKeOVB7nU1UTqQvHutGztR9Bh6cJIw900GnJLfeXauwYBx57P/BOj03PmZKsJvtmqHzA+ZXxHe2HovhJbxhXI8l5vA0+w=
Message-ID: <12c511ca05080513277de2d964@mail.gmail.com>
Date: Fri, 5 Aug 2005 13:27:51 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kernel status, 4 Aug 2005
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050805033322.2d4c0201.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050805020729.50146221.akpm@osdl.org>
	 <42F33DF0.6030901@cantab.net> <20050805033322.2d4c0201.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >   3190002    git-acpi.patch
> > >   68299      git-alsa.patch
> >
> > What are these numbers?
> >
> 
> File size in bytes.

The summary line from "diffstat" would be nicer (and more informative).

-Tony
