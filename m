Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTE3Pyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTE3Pyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:54:55 -0400
Received: from smtp2.wanadoo.es ([62.37.236.136]:36489 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263763AbTE3Pyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:54:55 -0400
Message-ID: <3ED781D3.8030408@wanadoo.es>
Date: Fri, 30 May 2003 18:07:47 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: matthartley@yahoo.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] linux-2.4.21-rc5-ac2
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Hartley wrote:

>Alan,

>After noticing that drivers/pci/pci.ids was over nine months old, I
>grabbed the latest list off of http://pciids.sourceforge.net, modded it
>to include a few recent submissions and to fix a couple of broken
>lines, and created this patch.

>Let me know if you have any problems with it.

There is not sync between kernel pci.ids and pciids DB since time ago.
Some ids are only in kernel, some ids newer in pciids and some ids are in both
with differents names. It is not so easy like to do a diff.
It's necessary to review every id from diff output _one by one._
But in general, pciids DB is more updated.

regards,
-- 
Software is like sex, it's better when it's bug free.



