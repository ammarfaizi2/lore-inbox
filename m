Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbTICJXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTICJXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:23:03 -0400
Received: from p5082930F.dip.t-dialin.net ([80.130.147.15]:57361 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S261307AbTICJXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:23:00 -0400
Date: Wed, 3 Sep 2003 09:22:55 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Will L G <diskman@kc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compressed VMLINUX Kernel
Message-ID: <20030903092254.A24905@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Will L G <diskman@kc.rr.com>,
	linux-kernel@vger.kernel.org
References: <004801c371c1$fc64b0f0$6501a8c0@zephyr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <004801c371c1$fc64b0f0$6501a8c0@zephyr>; from diskman@kc.rr.com on Tue, Sep 02, 2003 at 09:20:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 09:20:46PM -0500, Will L G wrote:
> I was wondering, is there some method or utility that will allow me to
> compress my kernel (vmlinux)? I was running an alpha and bzImage and zImage
> don’t work.  I read all the mans that I could lay my grubby little hands on

use 'make boot' instead. this will create arch/alpha/boot/vmlinux.gz

> but none of them mentioned HOW one is the compress a vmlinux kernel.  
>  
> The reason ask this is, I boot to linux using an OLD IDE drive and it takes
> sometime to read a 7mb file. I noticed that the original kernel
> (Redhat/Compaq derivative) was compressed and somewhat smaller, about less
> than half the size. Thanks, Will L G

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
