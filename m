Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbTE1UT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbTE1UT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:19:28 -0400
Received: from server1.comparato.de ([217.11.50.117]:35746 "HELO
	server1.comparato.de") by vger.kernel.org with SMTP id S264862AbTE1US1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:18:27 -0400
Message-ID: <3ED51CAE.1090708@burstedde.de>
Date: Wed, 28 May 2003 22:31:42 +0200
From: Carsten Burstedde <c@burstedde.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: via82cxxx.c compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried 2.4.21-rc5 today and it did not compile 
drivers/ide/pci/via82cxxx.c.  It says
PCI_DEVICE_ID_VIA_8237 undefined on line 77.  I commented this line out 
and it worked.

Machine is x86 Debian 3.0, gcc 2.95.4.

I am not on this list, so please CC if you like.

Carsten

