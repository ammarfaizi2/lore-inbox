Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVCNPfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVCNPfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVCNPfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:35:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:14248 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261549AbVCNPe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:34:58 -0500
Date: Mon, 14 Mar 2005 16:36:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][-mm][1/2] cifs: whitespace cleanups for file.c
In-Reply-To: <1110812782.2294.2.camel@smfhome.smfdom>
Message-ID: <Pine.LNX.4.62.0503141626400.2534@dragon.hyggekrogen.localhost>
References: <OF5618ED86.7D1043E7-ON87256FC4.00196859-86256FC4.0019866B@us.ibm.com>
  <Pine.LNX.4.62.0503141207550.2534@dragon.hyggekrogen.localhost>
 <1110812782.2294.2.camel@smfhome.smfdom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Steve French wrote:

> OK - the first of them is merged in to the cifs bk tree.

Thank you.


> The second one looks like an improvement on structuring of the cifs open
> logic but needs review.

Yes, it certainly does. I may be able to install windows in vmware or 
borrow a machine for it during the week to test the patch a bit myself, 
I'll see what I can do.


>  I may have a chance to test it later in the
> week.
> 
Great.


> Thanks.
> 
You're very welcome.

Would it be useful if I split the second patch into a few parts for you? I 
could split some of the (non cifs_open related) whitespace changes into 
one, the kfree related changes into another and then a third with the 
cifs_open rework. Would that make things easier for you?


-- 
Jesper


