Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSLKA27>; Tue, 10 Dec 2002 19:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbSLKA26>; Tue, 10 Dec 2002 19:28:58 -0500
Received: from dp.samba.org ([66.70.73.150]:5071 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266886AbSLKA26>;
	Tue, 10 Dec 2002 19:28:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools 0.9.3 -- "missing" issue 
In-reply-to: Your message of "Wed, 11 Dec 2002 00:27:52 BST."
             <3DF67878.6090703@oracle.com> 
Date: Wed, 11 Dec 2002 11:35:24 +1100
Message-Id: <20021211003644.217932C06D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DF67878.6090703@oracle.com> you write:
> Rusty Russell wrote:
> > 5) If you want to hack on the source:
> > 	aclocal && automake --add-missing --copy && autoconf

>   to modprobe vfat - but not the full irda stack, I'll report this
>   separately to Jean) _and_ on 2.4.20 (modular IrDA and PPP are

I'd appreciate receiving a copy of that irda report.  It's probably
not Jean's fault.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
