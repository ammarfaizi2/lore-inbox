Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJPX0U>; Wed, 16 Oct 2002 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSJPX0U>; Wed, 16 Oct 2002 19:26:20 -0400
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:57477 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S261525AbSJPX0Q>;
	Wed, 16 Oct 2002 19:26:16 -0400
Date: Wed, 16 Oct 2002 18:32:13 -0500
From: Matt Reppert <arashi@arashi.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS compile breakage in 2.5.43
Message-Id: <20021016183213.2378487f.arashi@arashi.yi.org>
In-Reply-To: <20021016.161643.30198311.davem@redhat.com>
References: <20021016180350.52bc09ad.arashi@arashi.yi.org>
	<20021016.161643.30198311.davem@redhat.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002 16:16:43 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:
>    Is this valid? gcc-2.95.3 doesn't like it at all.
>    [fs/afs/dir.c line 65]
> 
> David has patches coming to fix this.

Hm ... too bad this mail didn't get here just a minute sooner, I 
just* sent a patch for rxrpc too.

> It is valid, but only in newer versions of gcc.

I see ... I thought that might be the case. Thanks.

Matt
