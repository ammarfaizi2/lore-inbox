Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWH1NnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWH1NnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 09:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWH1NnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 09:43:06 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:6082 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750820AbWH1NnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 09:43:03 -0400
Date: Mon, 28 Aug 2006 22:44:50 +0900 (JST)
Message-Id: <20060828.224450.122594234.anemo@mba.ocn.ne.jp>
To: heiko.carstens@de.ibm.com
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] s390: fix do_gettimeoffset
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060828133456.GB9861@osiris.boeblingen.de.ibm.com>
References: <20060828133456.GB9861@osiris.boeblingen.de.ibm.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 15:34:56 +0200, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> kill-wall_jiffies.patch breaks s390's do_gettimeoffset(). Fix this and do a
> small whitespace cleanup while we are at it.

Oops, my fault.  Thank you for fixing it.

---
Atsushi Nemoto
