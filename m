Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVJXQyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVJXQyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVJXQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:54:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6533 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751162AbVJXQyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:54:50 -0400
Subject: Re: 2.6.14-rc5-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Badari Pulavarty <pbadari@gmail.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051024154342.GA24527@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <1130168434.6831.1.camel@localhost.localdomain>
	 <20051024154342.GA24527@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Oct 2005 18:21:37 +0100
Message-Id: <1130174497.12873.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-24 at 17:43 +0200, Adrian Bunk wrote:
> >   CC [M]  drivers/serial/jsm/jsm_tty.o
> > drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
> > drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named
> > `flip'
> >...
> 
> Quoting Andrew's announcement:
> 
>    - A number of tty drivers still won't compile.

Should only be jsm that won't compile for any mainstream platform, if
you find others that don't please email me.

