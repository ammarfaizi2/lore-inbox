Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTKETqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTKETqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:46:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12186 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263130AbTKETqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:46:03 -0500
Date: Wed, 5 Nov 2003 11:38:56 -0800
From: "David S. Miller" <davem@redhat.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 IrDA] IrCOMM might_sleep Oops
Message-Id: <20031105113856.479b1949.davem@redhat.com>
In-Reply-To: <20031105193953.GB24323@bougret.hpl.hp.com>
References: <20031105193953.GB24323@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003 11:39:53 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> 		<Original patch from Martin Diehl>
> 	o [CRITICA] Don't do copy_from_user() under spinlock
> 	o [CRITICA] Always access self->skb under spinlock

Applied.
