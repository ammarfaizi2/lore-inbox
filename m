Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUJGOqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUJGOqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUJGOqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:46:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53422 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266721AbUJGOp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:45:58 -0400
Subject: Re: [PATCH] poll(2) man page, likewise.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: linux@horizon.com, aeb@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410071005010.3331@chaos.analogic.com>
References: <20041007135110.16475.qmail@science.horizon.com>
	 <Pine.LNX.4.61.0410071005010.3331@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097156530.31754.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 14:42:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 15:26, Richard B. Johnson wrote:
> Wrong. It is a Linux kernel mistake to fail to implement a common
> system call properly.

Actually if you dig deeply only pselect() has posix guarantees, and we
don't implement that.

> So wake up. This is not a hobbiest thing anymore. The software
> has GOT to work as specified.

Take it up with whoever you paid for your installation

