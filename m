Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVDLAWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDLAWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVDLAWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:22:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:37007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261710AbVDLAWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:22:18 -0400
Date: Mon, 11 Apr 2005 17:22:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050411172226.19716a2c.akpm@osdl.org>
In-Reply-To: <d3ehut$boi$1@sea.gmane.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<d3ehut$boi$1@sea.gmane.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> MPlayer randomly crashes in various pthread_* calls when using binary
> codecs. 2.6.12-rc2-mm2 was ok. I tried to reverse
> fix-crash-in-entrys-restore_all.patch, but it didn't help.
> 

hm, could be anything.

Does 2.6.12-rc2 also fail?
