Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVHAWPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVHAWPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVHAWNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:13:14 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:27522 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261315AbVHAWCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:02:52 -0400
Message-ID: <42EE9C0F.30004@gmail.com>
Date: Tue, 02 Aug 2005 00:02:55 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH rc4-mm1] drivers/char/isicom.c old api rewritten
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
Could you send me critics and bugs?
Could somebody test it (but NOT now)?
Thanks.

 drivers/char/isicom.c  | 1610 
++++++++++++++++++++++++-------------------------
 include/linux/isicom.h |    8
 2 files changed, 817 insertions(+), 801 deletions(-)

Here it is (about 65 KiB):
http://www.fi.muni.cz/~xslaby/lnx/isi.txt

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

