Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUDUKKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUDUKKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264523AbUDUKKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:10:44 -0400
Received: from [61.11.60.89] ([61.11.60.89]:24338 "EHLO
	gateway.prodigylabs.net") by vger.kernel.org with ESMTP
	id S264503AbUDUKKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:10:37 -0400
Message-ID: <4086424B.9070206@prodigylabs.com>
Date: Wed, 21 Apr 2004 15:43:39 +0600
From: manu <manu@prodigylabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: booting problem!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all  iam new to this list.
i am trying to install the linux without bootloader.
i used dd  to write kernel image to /dev/hdc.
but when i try to boot from it. it is saying
 
 Loading.
 4000
 AX:0208
 BX:0200
 CX:0002
 DX:0000
 4000
iam using  2.4.22 kernel.

can anybody tell me whts the problem. when i tried same with /dev/fd0 (floppy) it  is booting fine.but i dont know whts the prolem with the compact flash,any ideas.
                                                            -manu 
 



