Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUFVUyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUFVUyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUFVUwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:52:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:19943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266021AbUFVUur convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:50:47 -0400
Date: Tue, 22 Jun 2004 13:53:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Eger <eger@havoc.gtf.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       garzik@havoc.gtf.org, jsimmons@infradead.org
Subject: Re: [PATCH] cirrusfb: it lives!
Message-Id: <20040622135331.3d1509b2.akpm@osdl.org>
In-Reply-To: <20040622202758.GA10135@havoc.gtf.org>
References: <20040622202758.GA10135@havoc.gtf.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger <eger@havoc.gtf.org> wrote:
>
> This patch brings the cirrusfb driver up to date with 2.6.

Olé

> cirrusfb
> has suffered bit rot like you wouldn't believe (last updated... 2.3.x era?).

My more venerable testbox has Cirrus hardware.  The problems have been noted ;)

> The driver will now compile again, and you can change to a high resolution 
> text mode with stty.  Known defects: doesn't play nice with X, nor fbset.
> Nonetheless, please apply to -mm and forward to mainline.

Shall do, thanks.
