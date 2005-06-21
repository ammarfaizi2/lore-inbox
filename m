Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVFUJlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVFUJlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVFUJiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:38:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24765 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261657AbVFUJhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:37:45 -0400
Date: Tue, 21 Jun 2005 02:37:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kdump documentation update to introduce use of irqpoll
Message-Id: <20050621023701.219705a4.akpm@osdl.org>
In-Reply-To: <20050621092613.GF3746@in.ibm.com>
References: <20050621092613.GF3746@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> o Specify "irqpoll" command line option which loading second kernel. This
>    helps in reducing driver initialization failures in second kernel due
>    to shared interrupts.

Well that rather assumes we've merged the irqpoll patch.

Is Alan OK with that?
