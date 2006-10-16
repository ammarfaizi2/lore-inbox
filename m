Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422888AbWJPWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWJPWgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422891AbWJPWgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:36:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422888AbWJPWgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:36:43 -0400
Date: Mon, 16 Oct 2006 15:36:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <R.E.Wolff@BitWizard.nl>,
       Amit Gud <gud@eth.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Char: correct pci_get_device changes
Message-Id: <20061016153625.eda40799.akpm@osdl.org>
In-Reply-To: <1966866271061818079@wsc.cz>
References: <1966866271061818079@wsc.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006 01:36:45 +0200 (CEST)
Jiri Slaby <jirislaby@gmail.com> wrote:

> correct pci_get_device changes

I suspect this patch was against -mm, but fixes problems in mainline, to
which it doesn't apply.

Could I have a new one against mainline please?  With a changelog updated
to reflect Alan's comments?

Thanks.
