Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUADNDg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 08:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUADNBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 08:01:38 -0500
Received: from [24.35.117.106] ([24.35.117.106]:43651 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265644AbUADNB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 08:01:26 -0500
Date: Sun, 4 Jan 2004 08:01:20 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: Re: make modules_install problem in 2.6.0-rc1-mm1
In-Reply-To: <Pine.LNX.4.58.0401040749180.11783@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0401040800300.11783@localhost.localdomain>
References: <Pine.LNX.4.58.0401040749180.11783@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004, Thomas Molina wrote:

> I get the following message when compiling profile suport into 
> 2.6.0-rc1-mm1:
> 
> WARNING: /lib/modules/2.6.1-rc1-mm1/kernel/arch/i386/oprofile/oprofile.ko needs unknown symbol cpu_possible
> 
> My .config file is attached.

Sorry about that.  The Subject should obviously refer to 2.6.1-rc1-mm1, 
not 2.6.0.
