Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVGQP6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVGQP6K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 11:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVGQP6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 11:58:10 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:16103 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261324AbVGQP6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 11:58:08 -0400
Subject: Re: [2.6 patch] net/bluetooth/: cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: bluez-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050717145709.GI3613@stusta.de>
References: <20050717145709.GI3613@stusta.de>
Content-Type: text/plain
Date: Sun, 17 Jul 2005 17:58:03 +0200
Message-Id: <1121615883.22662.38.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch contains the following cleanups:
> - remove BT_DMP/bt_dump
> - remove the following unneeded EXPORT_SYMBOL's:
>   - hci_core.c: hci_dev_get
>   - hci_core.c: hci_send_cmd
>   - hci_event.c: hci_si_event

is this the same patch you sent me last time? I still have one of your
cleanup patches in my queue. I simply was to lazy to get them back into
mainline.

Regards

Marcel


