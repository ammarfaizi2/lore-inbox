Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbUKRHH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbUKRHH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 02:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbUKRHFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 02:05:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:28095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262658AbUKRHDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 02:03:22 -0500
Date: Wed, 17 Nov 2004 23:03:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Altivec support for RAID-6
Message-Id: <20041117230306.3ca3e241.akpm@osdl.org>
In-Reply-To: <20041117230100.515c6278.akpm@osdl.org>
References: <419C46C7.4080206@zytor.com>
	<20041117230100.515c6278.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>  >
>  >   $(obj)/raid6int1.c:   $(src)/raid6int.uc $(src)/unroll.pl FORCE
> 
>  So we require that raid6int.uc propagate through the system with the x bit
>  set.

err, I think I misread that.  Ignore.
