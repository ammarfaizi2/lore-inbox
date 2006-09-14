Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWINVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWINVUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWINVUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:20:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751181AbWINVUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:20:50 -0400
Date: Thu, 14 Sep 2006 14:20:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] (hopefully) final SCSI fixes for 2.6.19
Message-Id: <20060914142044.4272fc56.akpm@osdl.org>
In-Reply-To: <1158268378.3514.61.camel@mulgrave.il.steeleye.com>
References: <1158268378.3514.61.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 16:12:58 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> The patch is here
> 
> master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git
> 
> However, as there's only a single patch in there, I attach it in case
> you'd prefer simply to apply it as a patch rather than merge a single
> patch tree.

<digs around>

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/broken-out/fix-panic-when-reinserting-adaptec-pcmcia-scsi-card.patch
might be handy too.  Your ack is my command.
