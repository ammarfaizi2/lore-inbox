Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVBDABD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVBDABD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbVBDABD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:01:03 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:29647 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261827AbVBDAA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:00:57 -0500
Date: Fri, 4 Feb 2005 09:00:40 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.11-rc2-mm2] mips: iomap
Message-Id: <20050204090040.61ce25d2.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050203123715.GB8509@linux-mips.org>
References: <20050131074618.09e65a6b.yuasa@hh.iij4u.or.jp>
	<20050203123715.GB8509@linux-mips.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

On Thu, 3 Feb 2005 13:37:15 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Jan 31, 2005 at 07:46:18AM +0900, Yoichi Yuasa wrote:
> 
> > This patch adds iomap functions to MIPS system.
> 
> And it still only works for a single PCI bus.

Which boards are there a problem?
ocelot-c and ocelot-g?

Yoichi
