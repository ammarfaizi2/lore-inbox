Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUFPKxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUFPKxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 06:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUFPKxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 06:53:42 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54795 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266237AbUFPKxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 06:53:38 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jmorris@redhat.com (James Morris)
Subject: Re: [SELINUX][PATCH 1/4] Fine-grained Netlink support - SELinux headers update
Cc: jgarzik@pobox.com, akpm@osdl.org, davem@redhat.com, sds@epoch.ncsc.mil,
       chrisw@osdl.org, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       debian-kernel@lists.debian.org
Organization: Core
In-Reply-To: <Xine.LNX.4.44.0406152334380.30782-100000@thoron.boston.redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BaXwF-0000BM-00@gondolin.me.apana.org.au>
Date: Wed, 16 Jun 2004 20:46:39 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
> 
> The script lives in the SELinux policy compilation package, which is
> considered the source of truth for these headers.  They are only ever
> regenerated manually when significant changes are made to SELinux (like
> this), and I don't think there is any advantage in doing this in the
> kernel tree.

The Debian crowd might get into a fit over this with arguments over the
preferred form of modification and the GPL :)
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
