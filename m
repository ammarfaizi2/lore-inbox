Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUHJLPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUHJLPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHJLPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:15:22 -0400
Received: from bay1-f15.bay1.hotmail.com ([65.54.245.15]:38662 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264297AbUHJLPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:15:19 -0400
X-Originating-IP: [81.224.186.8]
X-Originating-Email: [tcambrant@hotmail.com]
From: "Tim Cambrant" <tcambrant@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Finding out what certain kernel config options are dependant on
Date: Tue, 10 Aug 2004 13:15:18 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY1-F15JkUwWpSWerO0001ad67@hotmail.com>
X-OriginalArrivalTime: 10 Aug 2004 11:15:18.0489 (UTC) FILETIME=[518D4490:01C47ECB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm sorry for not posting a more development related question, but I 
know there is a need for finding out why certain options in make config are 
preselected, and why we can't choose not to use them. If this doesn't make 
sense, consider this:
On my machine, with 2.6.8-rc4-mm1 (and all the other versions I've tried so 
far in 2.6) CONFIG_CRYPTO is preselected, and I can't remove it. I'm not 
interested in the cryptographic API at all. So what driver or option did i 
enable that requires CONFIG_CRYPTO?
I'd appreciate help on finding this out, since I'd like to remove it all 
from my .config. Is there a script or some other automated way on finding 
this out?
If I find out that CONFIG_CRYPTO really is needed in the kernel all the way, 
I appologize for asking such a stupid question, but then I'd wonder why 
there is even an option for that.

_________________________________________________________________
Auktioner: Tjäna en hacka på gamla prylar http://tradera.msn.se

