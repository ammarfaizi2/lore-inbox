Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUAWHeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265708AbUAWHeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:34:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:41101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265658AbUAWHeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:34:24 -0500
Date: Thu, 22 Jan 2004 23:35:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Remove useless cruft from ATM HE driver.
Message-Id: <20040122233510.216f4358.akpm@osdl.org>
In-Reply-To: <E1Ajuub-0000xS-00@hardwired>
References: <E1Ajuub-0000xS-00@hardwired>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@redhat.com wrote:
>
> Echoing changes done in 2.4. (It now has a pci_pool_create backport).

drivers/atm/he.c: In function `he_start':
drivers/atm/he.c:1474: too many arguments to function `pci_pool_create'
