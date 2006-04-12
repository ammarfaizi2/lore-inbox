Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWDLP4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWDLP4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWDLP4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:56:07 -0400
Received: from [82.97.11.139] ([82.97.11.139]:49899 "EHLO
	ckr.zeninteractif.com") by vger.kernel.org with ESMTP
	id S1751010AbWDLP4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:56:05 -0400
Message-ID: <443D230B.40806@wanadoo.fr>
Date: Wed, 12 Apr 2006 17:55:55 +0200
From: =?ISO-8859-1?Q?S=E9bastien_CRAMATTE?= <s.cramatte@wanadoo.fr>
Organization: Zen Soluciones
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Bug  with make Menuconfig menu
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I can't configure my  intel e1000 card with make menuconfig  
I try  to compile 2.4.21 RHEL 4 + patch freevps 1.5.7  see (www.freevps.com)

When I try to enter in Network Device Support --> Ethernet (1000) I 
obtain this error

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu36: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Erreur 1

Thanks for your help

