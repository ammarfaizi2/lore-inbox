Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270520AbUJUEhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270520AbUJUEhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbUJUEhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:37:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:33245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270520AbUJUEb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:31:59 -0400
Date: Wed, 20 Oct 2004 21:29:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, shemminger@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 IrDA] Stir driver usb reset fix
Message-Id: <20041020212912.03ba1b04.akpm@osdl.org>
In-Reply-To: <20041020210938.2a8e38d1.davem@davemloft.net>
References: <20041020010733.GJ12932@bougret.hpl.hp.com>
	<20041020155349.4514de82.akpm@osdl.org>
	<20041020225418.GA26559@bougret.hpl.hp.com>
	<20041020210938.2a8e38d1.davem@davemloft.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
>  > 	Do you want to take care of that and forward a new patch
>  > directly to Andrew ?
> 
>  Andrew/Jeff, I can work on the integration of all of Jean's
>  patches and I can also resolve all the conflicts myself.

Go wild - there's nothing particularly messy in there.
