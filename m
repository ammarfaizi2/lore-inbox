Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWIQQxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWIQQxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 12:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWIQQxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 12:53:40 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:45952 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964957AbWIQQxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 12:53:39 -0400
Subject: Re: bluetooth oops during resume from ram
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <20060917140952.GA3349@elf.ucw.cz>
References: <20060917140952.GA3349@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 18:52:59 +0200
Message-Id: <1158511979.24941.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> If I suspend-to-RAM with usb active on thinkpad x60, I get an
> oops. Machine works okay after that, but...
> 
> it seems bluetooth is scribbling over more memory than was allocated
> (?)

not that I am aware of. Is this a plain 2.6.18-rc6 or did you apply
additional patches that might have caused this behavior?

Regards

Marcel


