Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUHXPOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUHXPOC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHXPOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:14:02 -0400
Received: from zenon.apartia.fr ([82.66.93.83]:39865 "EHLO zenon.apartia.com")
	by vger.kernel.org with ESMTP id S267961AbUHXPN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:13:58 -0400
Message-ID: <412B5B35.7020701@apartia.fr>
Date: Tue, 24 Aug 2004 17:13:57 +0200
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040722 Debian/1.7.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TG3(Tigoon) & Kernel 2.4.27
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When I try to compile kernel 2.4.27 for one of my servers i get this error.
--------------
drivers/net/net.o(.text+0x17550): In function `tg3_request_firmware': : 
undefined reference to `request_firmware'
drivers/net/net.o(.text+0x17652): In function `tg3_request_firmware': : 
undefined reference to `release_firmware'
-------------

Any clue?

PS: I can include a part of my .config


