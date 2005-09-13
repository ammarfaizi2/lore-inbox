Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVIMFEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVIMFEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVIMFEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:04:30 -0400
Received: from ozlabs.org ([203.10.76.45]:59627 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751058AbVIMFE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:04:29 -0400
Date: Tue, 13 Sep 2005 15:01:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Florin Iucha <florin@iucha.net>
Cc: Linul Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: recent (2.6.12+) config for power mac G5?
Message-ID: <20050913050134.GB26162@krispykreme>
References: <20050913035703.GE18079@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913035703.GE18079@iucha.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Does anybody have a working config for a recent power mac dual G5 box?
> I am trying to configure it, but I end up with unbootable kernels. As
> a recent "switcher" I have trouble making the .config transition from
> i386 to ppc64 ;)

The defconfig or g5_defconfig should work. (eg make g5_defconfig)

Anton
