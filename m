Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUIAInx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUIAInx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUIAInx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:43:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:8393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265029AbUIAInp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:43:45 -0400
Date: Wed, 1 Sep 2004 01:41:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: niv@us.ibm.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.6.9-rc1-mm2
Message-Id: <20040901014118.45204bcb.akpm@osdl.org>
In-Reply-To: <200409010833.i818XPZ04210@owlet.beaverton.ibm.com>
References: <41351C86.7000704@us.ibm.com>
	<200409010833.i818XPZ04210@owlet.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley <ricklind@us.ibm.com> wrote:
>
> But considering I ran make oldconfig on this and chose
>  the defaults in each and every case, should I end up with a config that
>  doesn't compile?

No, you shouldn't.  This indicates a Kconfig bug.
