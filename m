Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265926AbTFVV2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbTFVV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:28:32 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:6273 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S265926AbTFVV2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:28:31 -0400
Date: Sun, 22 Jun 2003 16:45:55 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Florin Iucha <florin@iucha.net>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73
In-Reply-To: <Pine.LNX.4.56.0306221615230.11747@dust>
Message-ID: <Pine.LNX.4.56.0306221635550.1758@dust.p68.rivermarket.wintek.com>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
 <20030622204607.GA16386@iucha.net> <Pine.LNX.4.56.0306221615230.11747@dust>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Alex Goddard wrote:

> An attempt at a fix.  It just moves pci_desroy_dev outside the #ifdef).  
> I have no idea if this is the correct way to fix this.  It compiles okay.

It also boots and seems to run okay.

-- 
Alex Goddard
agoddard@purdue.edu
