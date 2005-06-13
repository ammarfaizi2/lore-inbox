Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVFNBjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVFNBjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 21:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVFNBjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 21:39:55 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:8327 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261303AbVFNBjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 21:39:53 -0400
Date: Tue, 14 Jun 2005 01:45:11 +0200
From: Voluspa <lista1@telia.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: mouse still losing sync and thus jumping around
Message-Id: <20050614014511.7dc1f083.lista1@telia.com>
In-Reply-To: <200506131647.53603.dtor_core@ameritech.net>
References: <20050613234039.7d3ed895.lista1@telia.com>
	<200506131647.53603.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005 16:47:53 -0500 Dmitry Torokhov wrote:

> Try setting frequency to once a minute, that should help.

I don't think I'd get much work done if the mouse was updated once a
minute only...

Gkrellm can go as low as 1 update per second for its graphical output.
Don't know if the "below the hood" polling is reduced to the same freq.

Mvh
Mats Johannesson
--
