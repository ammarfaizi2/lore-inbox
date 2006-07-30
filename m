Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWG3LKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWG3LKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWG3LKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:10:16 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:54277 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932264AbWG3LKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:10:14 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Subject: Re: Linux v2.6.18-rc3
Date: Sun, 30 Jul 2006 12:10:14 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <06ATUBD12@briare1.heliogroup.fr>
In-Reply-To: <06ATUBD12@briare1.heliogroup.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301210.14063.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 13:21, Hubert Tonneau wrote:
> > Linus Torvalds wrote:
> >
> > In fact, it's been pretty quiet since too, which I attribute to
> > 2.6.18-rc2 just being so good
>
> Not 'so good' but 'no boot'
>
> Freeing unused kernel memory: 152 K
> Inconsistency detected by ld.so: rtld.c: 1192: ld_main:
> Assertion '(void *) ph->p_vaddr == _rtld_local_._dl_sysinfo_dso' failed !
> Kernel panic - not syncing: Attempted to kill init !
>
> > but there really hasn't been tons of stuff.

It's not that you've set COMPAT_VDSO to n, and then don't have a recent enough 
glibc, is it?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
