Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUB2Hcv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUB2Hct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:32:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:6334 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262003AbUB2Hbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:31:47 -0500
Subject: Re: Dropping CONFIG_PM_DISK?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20040229072959.GB209@elf.ucw.cz>
References: <20040228230039.GA246@elf.ucw.cz>
	 <1078012320.906.9.camel@gaston>  <20040229072959.GB209@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1078039327.904.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 29 Feb 2004 18:22:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Except that pmdisk code is +/- readable, swsusp is not...
> 
> Would you be willing to either maintain pmdisk or (preffered) split it
> up and submit me pieces?

Heh, if I had time ... :)

Ben.


