Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTIQWzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbTIQWzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:55:43 -0400
Received: from zok.SGI.COM ([204.94.215.101]:2965 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262888AbTIQWzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:55:42 -0400
Date: Wed, 17 Sep 2003 15:55:22 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: pfg@sgi.com, linux-kernel@vger.kernel.org, hch@verein.lst.de
Subject: Re: [PATCH] Altix console driver
Message-ID: <20030917225522.GA26192@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, pfg@sgi.com,
	linux-kernel@vger.kernel.org, hch@verein.lst.de
References: <20030917222414.GA25931@sgi.com> <20030917152139.42a1ce20.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917152139.42a1ce20.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 03:21:39PM -0700, Andrew Morton wrote:
> jbarnes@sgi.com (Jesse Barnes) wrote:
> >
> > Just a simple addition to drivers/char for the Altix serial console.
> > 
> >  MAINTAINERS              |    6 
> >  drivers/char/Kconfig     |   16 
> >  drivers/char/Makefile    |    1 
> >  drivers/char/sn_serial.c | 1189 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> Would it be more appropriate to place this under arch/ia64?

I've always been told not to do that.  Christoph? ;)

Jesse
