Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVFLVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVFLVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFLVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 17:03:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261212AbVFLVDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 17:03:13 -0400
Date: Sun, 12 Jun 2005 14:02:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Adds support for TEA5767chipset on V4L
Message-Id: <20050612140248.620eee46.akpm@osdl.org>
In-Reply-To: <42AC6162.2020606@brturbo.com.br>
References: <42AC6162.2020606@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>
>  This patch adds support for TEA5767 FM radio tuner.
> 
>  Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> 
>  PS.: This patch completes first series of synchronizing patches between
>  V4L CVS and 2.6.12-rc6-mm1.

umm, this 2.7MB patch appears to remove 143 files.
