Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTKETx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTKETvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:51:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21146 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263170AbTKETvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:51:24 -0500
Date: Wed, 5 Nov 2003 11:44:16 -0800
From: "David S. Miller" <davem@redhat.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: IrDA patches for 2.6.X
Message-Id: <20031105114416.759b29c7.davem@redhat.com>
In-Reply-To: <20031105193906.GA24323@bougret.hpl.hp.com>
References: <20031105193906.GA24323@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003 11:39:06 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> 	Here is a set of patches for 2.6.0-test10. As per Linus
> requirement, those are only critical bug fixes. The first Oops was
> experienced by various people on LKML, the second by me.
>         Patches tested on 2.6.0-test9, please push to Linus...

All applied, thank you.

Please CC: netdev@oss.sgi.com instead of linux-kernel next time
as that is where networking developers read and could review
your changes.

Thanks again.
