Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271719AbTHMIz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 04:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271720AbTHMIz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 04:55:27 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:48550 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S271719AbTHMIz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 04:55:27 -0400
Date: Wed, 13 Aug 2003 11:55:25 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
cc: linux-fs@vger.kernel.org
Subject: 2.6.0test2mm4 reiser bug? Buffer I/O error on device hda2, logica...
Message-ID: <Pine.LNX.4.56.0308131151070.11964@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have some problems with 2.6.0test2mm4.
I get the error from subject when I try to read a file on the disk.
In userspace I get EIO.

With 2.6.0test3mm1 the problem seems to disapear!

But I get something like:
vs-8115: get_num_ver: not directory item
Do I have to worry?

Thanks!
---
Catalin(ux) BOIE
catab@deuroconsult.ro
