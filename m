Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUDHRFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUDHRFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:05:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:59621 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261937AbUDHRFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:05:06 -0400
Message-ID: <40758649.1090803@onlinehome.de>
Date: Thu, 08 Apr 2004 19:05:13 +0200
From: Mathias Peters <empy@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: "lost" drivers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:daf03fd6329e0ac81f958414b71043cb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

recently i have problems with my 2.6.4 on debian sid. the server is not 
starting with the message "[drm radeon_cp_init] *ERROR* radeon_cp_init 
called without lock held". i had a short look on dmesg a found out that 
also a sound driver was not found, allthough i picked it when doing 
"make menuconfig".
First i thought, i might have made a mistake when konfiguring the 
kernel. But i compiled it several times and even changed to version 2.6.5.
maybe anyone, who has experienced this problem, can help me
thank you
matze
