Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759811AbWLEVx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759811AbWLEVx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759874AbWLEVxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:53:25 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38883
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759781AbWLEVxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:53:24 -0500
Date: Tue, 05 Dec 2006 13:53:30 -0800 (PST)
Message-Id: <20061205.135330.26534788.davem@davemloft.net>
To: akpm@osdl.org
Cc: jengelh@linux01.gwdg.de, jsipek@cs.sunysb.edu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 21/35] Unionfs: Inode operations
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061205135017.3be94142.akpm@osdl.org>
References: <11652354711835-git-send-email-jsipek@cs.sunysb.edu>
	<Pine.LNX.4.61.0612052222190.18570@yvahk01.tjqt.qr>
	<20061205135017.3be94142.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Dec 2006 13:50:17 -0800

> This
> 
> 	/*
> 	 * Lorem ipsum dolor sit amet, consectetur
> 	 * adipisicing elit, sed do eiusmod tempor
> 	 * incididunt ut labore et dolore magna aliqua.
> 	 */
> 
> is probably the most common, and is what I use when forced to descrog
> comments.

This is the style I try to use and enforce too.
