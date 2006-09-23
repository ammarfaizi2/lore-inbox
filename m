Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIWVLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIWVLG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWIWVLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:11:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53400 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750783AbWIWVLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:11:04 -0400
Subject: Re: [PATCH] memcpy_fromio() missing in istallion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060923002031.GW29920@ftp.linux.org.uk>
References: <20060923002031.GW29920@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 23 Sep 2006 22:35:30 +0100
Message-Id: <1159047330.24572.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-23 am 01:20 +0100, ysgrifennodd Al Viro:
> memcpy() from iomem is a bad thing...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Alan Cox <alan@redhat.com>

