Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTKJMqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 07:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTKJMqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 07:46:42 -0500
Received: from [160.216.153.99] ([160.216.153.99]:8463 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S262861AbTKJMql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 07:46:41 -0500
Date: Mon, 10 Nov 2003 13:47:22 -0500 (EST)
From: Tomas Konir <moje@vabo.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <20031110120949.86290.qmail@web40907.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0311101345280.11279@moje.vabo.cz>
References: <20031110120949.86290.qmail@web40907.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Bradley Chapman wrote:

> Mr. Rossetti,
> 
> It is horribly RTFM.
> 
> man 2 sendfile is what you're after.

mhm
sendfile() can copy extended attributes and ACL ?

(i'm not think, that copy is the right candidate to syscall)

	MOJE

-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

