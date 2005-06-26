Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVFZRxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVFZRxr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVFZRxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:53:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54214 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261511AbVFZRxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:53:41 -0400
Subject: Re: IDE probing IDE_MAX_HWIFS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Warne <nick@linicks.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506251210.37623.nick@linicks.net>
References: <200506251210.37623.nick@linicks.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119808271.28644.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Jun 2005 18:51:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-06-25 at 12:10, Nick Warne wrote:
> Looking at the Kconfig, I see APLHA & SUPERH do get an option to change this 
> to suit
> drivers/ide/Kconfig

To make embedded systems as small as possible

> Now my question :-)  Is there a specific reason why this isn't included in 
> other architectures?

They are not embedded ?


