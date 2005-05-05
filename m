Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVEESBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVEESBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVEESB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:01:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:7863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbVEESBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:01:25 -0400
Date: Thu, 5 May 2005 11:00:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.12-rc3-mm3
Message-Id: <20050505110052.62c1c2cb.akpm@osdl.org>
In-Reply-To: <20050505115502.GA4414@electric-eye.fr.zoreil.com>
References: <20050504221057.1e02a402.akpm@osdl.org>
	<20050505115502.GA4414@electric-eye.fr.zoreil.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> wrote:
>
> Andrew Morton <akpm@osdl.org> :
> [...]
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> 
> r8169-new-pci-id.patch was announced in 2.6.12-rc3-mm1. It disappeared in
> 2.6.12-rc3-mm{2/3} without notification.

Nope, it's in -rc3-mm3.

> ...
> 
> On a related note, is it suggested to wait for a renewed -netdev tree or
> to feed the pending r8169 stuff to -mm ?
> 

You may as well send them out - I'll scoop them up.  Normally I'll autospam
Jeff and Dave with net stuff until one of them takes it ;) 
