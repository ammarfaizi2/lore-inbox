Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267373AbUHDTJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267373AbUHDTJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUHDTJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:09:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:20648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267373AbUHDTJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:09:16 -0400
Date: Wed, 4 Aug 2004 12:07:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: dsaxena@plexity.net, greg@kroah.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: [PATCH][5/3][ARM] PCI quirks update for ARM
Message-Id: <20040804120731.5985073a.akpm@osdl.org>
In-Reply-To: <1091625077.4383.2728.camel@hades.cambridge.redhat.com>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
	<20040803193716.GA16737@plexity.net>
	<1091625077.4383.2728.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> Thanks. I did the rest of the architectures too -- it's all at 
>  bk://linux-mtd.bkbits.net/quirks-2.6
> 
>  It probably doesn't want to go to Linus until after 2.6.8 is released,
>  but perhaps we could put it in the -mm tree until then?

Yup, I added the above tree to the -mm lineup.
