Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSKTRDl>; Wed, 20 Nov 2002 12:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSKTRDl>; Wed, 20 Nov 2002 12:03:41 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:30661 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP
	id <S261613AbSKTRDi>; Wed, 20 Nov 2002 12:03:38 -0500
Date: Wed, 20 Nov 2002 15:10:39 -0200
From: Lucio Maciel <abslucio@terra.com.br>
To: Rus Foster <rghf@fsck.me.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patching 2.5.xx
Message-Id: <20021120151039.2c308e56.abslucio@terra.com.br>
In-Reply-To: <20021120170131.D63367-100000@freebsd.rf0.com>
References: <20021120170131.D63367-100000@freebsd.rf0.com>
Organization: absoluta
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


just go into your kernel source dir and patch -p1

bash-2.05a$ cd linux
bash-2.05a$ zcat ../patch-2.5.48.gz |patch -p1

On Wed, 20 Nov 2002 17:03:30 +0000 (GMT)
Rus Foster <rghf@fsck.me.uk> wrote:

> Hi All,
> I've decided to start trying out the 2.5 kernels and I've got the 2.5.47
> tarball and the 2.5.48 patch. However looking at the diff file its trying
> to create an a and b directory. Is there a special significance for this
> and how do I go about applying the patch?
> 
> Rgds
> 
> Rus Foster
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net
