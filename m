Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267317AbUHPBz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbUHPBz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267320AbUHPBz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:55:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:19689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267317AbUHPBzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:55:25 -0400
Date: Sun, 15 Aug 2004 18:53:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Richter <thor@math.TU-Berlin.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netmos patches
Message-Id: <20040815185328.57717f72.akpm@osdl.org>
In-Reply-To: <200408100906.LAA11342@cleopatra.math.tu-berlin.de>
References: <20040809164623.5b7f9983.akpm@osdl.org>
	<200408100906.LAA11342@cleopatra.math.tu-berlin.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Richter <thor@math.TU-Berlin.DE> wrote:
>
> The following is a patch against
>  2.6.8-rc4 to add support for all NetMOS devices I could get hold of:

This doesn't work any better than the previous one?

drivers/parport/parport_pc.c:2677: redefinition of `netmos_9705'
drivers/parport/parport_pc.c:2666: `netmos_9705' previously defined here

