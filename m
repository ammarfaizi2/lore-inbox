Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTIPCb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 22:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTIPCb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 22:31:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:21924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261754AbTIPCb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 22:31:58 -0400
Date: Mon, 15 Sep 2003 19:32:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: jjluza <jjluza@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test5-mm2: Unknown symbol when modprobe atm
Message-Id: <20030915193228.122b52c2.akpm@osdl.org>
In-Reply-To: <200309160153.59196.jjluza@yahoo.fr>
References: <200309160153.59196.jjluza@yahoo.fr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jjluza <jjluza@yahoo.fr> wrote:
>
> I try to make test5-mm2 work on my gateway
>  I need to load module atm and pppoatm
>  these 2 modules return errors when I modprobe them.
>  dmesg says :
>  atm: Unknown symbol try_atm_clip_ops
>  pppoatm: Unknown symbol pppoatm_ioctl_set

Please send your .config

