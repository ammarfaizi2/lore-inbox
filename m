Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965435AbWIRGQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965435AbWIRGQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 02:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965466AbWIRGQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 02:16:05 -0400
Received: from [220.227.188.61] ([220.227.188.61]:60049 "EHLO
	gateway.innomedia.soft.net") by vger.kernel.org with ESMTP
	id S965435AbWIRGQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 02:16:03 -0400
Message-ID: <450E3C0A.20406@innomedia.soft.net>
Date: Mon, 18 Sep 2006 11:56:18 +0530
From: Chinmaya Mishra <chinmaya@innomedia.soft.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel-owner@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Kernel panic occurs with ucdsnmp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am trying to compile the uCLinux's distribution with enabling the 
'ucdsnmp'.
It will successfully compiled, image and romfs.img is created.
But when i am trying to boot with this image I am getting the following
error message....

.............................
Other stuff added by David S. Miller <davem@redhat.com>
VFS: Mounted root (romfs filesystem) readonly.
Freeing init memory: 44K
Warning: unable to open an initial console.
Kernel panic: Attempted to kill init!
Panic reset

After this it will halts. If i am not enable the 'ucdsnmp' package it
works fine. What is the resean of this .....

WORNING: UNABLE TO OPEN AN INITIAL CONSOLE.
KERNEL PANIC: ATTEMPTED TO KILL INIT!
PANIC RESET

Please tell me where is the mistake ?

Tahnks in advance.
Chinmaya



