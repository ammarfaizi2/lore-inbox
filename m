Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUAUVmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266029AbUAUVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:42:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:43399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266028AbUAUVmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:42:20 -0500
Date: Wed, 21 Jan 2004 13:43:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eduard Roccatello <lilo.please.no.spam@roccatello.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1-mm5] Unable to handle kernel paging request
Message-Id: <20040121134339.68fea573.akpm@osdl.org>
In-Reply-To: <200401211018.51865.lilo.please.no.spam@roccatello.it>
References: <200401211018.51865.lilo.please.no.spam@roccatello.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Roccatello <lilo.please.no.spam@roccatello.it> wrote:
>
> 2.6.1-mm5 gives me  "Unable to handle kernel paging request" on load and 
> then it hangs up.

If you disable ipv6 in kernel config, does it boot up OK?
