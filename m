Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWE1FLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWE1FLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 01:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWE1FLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 01:11:30 -0400
Received: from 8.ctyme.com ([69.50.231.8]:44476 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751706AbWE1FL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 01:11:29 -0400
Message-ID: <44793100.50707@perkel.com>
Date: Sat, 27 May 2006 22:11:28 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Asus K8N-VM Motherboard Ethernet Problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a problem with the forcedeth driver not being compatible with 
the Asus K8N-VM motherboard? I installed Fedora Core 5 and the Ethernet 
doesn't want to work. I installed the latest FC5 kernel which is some 
flavor og 2.6.16 and it still doesn't work. The FC4 CD and rescue disk 
don't work either. Windows XP however does work so I know that hardware 
is good.

lspci says the hardware is an nVidia MCP51 ethernet controller. What am 
I missing?

Thanks in advance.

