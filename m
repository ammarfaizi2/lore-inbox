Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVG3AzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVG3AzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVG3Axe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:53:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262794AbVG3Awg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:52:36 -0400
Date: Fri, 29 Jul 2005 17:51:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: Holger.Kiehl@dwd.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: As of 2.6.13-rc1 Fusion-MPT very slow
Message-Id: <20050729175122.7e1e9a2d.akpm@osdl.org>
In-Reply-To: <91888D455306F94EBD4D168954A9457C035CB329@nacos172.co.lsil.com>
References: <91888D455306F94EBD4D168954A9457C035CB329@nacos172.co.lsil.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Moore, Eric Dean" <Eric.Moore@lsil.com> wrote:
>
>  Regarding the 1st issue, can you try this patch out.  It maybe in the
>  -mm branch. Andrew cc'd on this email can confirm.
> 
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6
>  .13-rc3-mm3/broken-out/mpt-fusion-dv-fixes.patch

Yes, that's part of 2.6.13-rc3-mm3.
