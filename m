Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272327AbTHEBCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272332AbTHEBAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:00:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:12257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272318AbTHEA7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:59:07 -0400
Date: Mon, 4 Aug 2003 18:03:59 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] more callbacks for pci powermanagment
In-Reply-To: <20030726230059.GA546@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308041803120.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Some PCI devices need to act during power-on... Greg refused to apply
> it waiting for you, but you probably remember that discussion.

I do remember, and am holding off on this for a few days until I have a 
chance to do some of the necessary PM infrastructure to support this 
globally. 


	-pat

