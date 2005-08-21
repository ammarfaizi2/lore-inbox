Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVHUIwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVHUIwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 04:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVHUIwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 04:52:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750869AbVHUIwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 04:52:40 -0400
Date: Sun, 21 Aug 2005 01:49:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at "fs/exec.c":777
Message-Id: <20050821014945.52df641e.akpm@osdl.org>
In-Reply-To: <20050818021908.GA11047@schmorp.de>
References: <20050818021908.GA11047@schmorp.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann <schmorp@schmorp.de> wrote:
>
> If wanted, I can probably reproduce
> that without the nvidia kernel module loaded.
> 

Yes, please do that, thanks.
