Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTHaMXw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 08:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTHaMXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 08:23:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:25773 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261360AbTHaMXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 08:23:51 -0400
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Sun, 31 Aug 2003 14:23:53 +0200
MIME-Version: 1.0
Subject: Re: PROBLEM: Powerquest Drive Image let the kernel panic
Message-ID: <3F5204F9.4235.257AE4F0@localhost>
In-reply-to: <3F4755C3.27525.3B23996@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) one line summary: 
> Powerquest Drive Image (PQDI 2002) images (56 files, each ~700MB of 
> size)  are stored on a Linux server and published via Samba. When 
> verifying them  with PQDI from a Win XP client, the Linux kernel 
> panic with an OOPS. Linux  has to be resetted hard. 

Now I also get the kernel panic when copying about 4GB of data from a 
Win XP client to the samba share. I can drop the oops-message if 
somebody is asking for.

Has nobody an idea how to fix this problem?

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

