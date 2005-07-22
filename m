Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVGVJrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVGVJrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVGVJrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:47:03 -0400
Received: from [202.133.243.130] ([202.133.243.130]:64008 "EHLO sh.alchip.com")
	by vger.kernel.org with ESMTP id S261543AbVGVJrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:47:02 -0400
Message-ID: <003401c58ea2$4dfd76f0$5601010a@ashley>
From: "Ashley" <ashleyz@alchip.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel cached memory
Date: Fri, 22 Jul 2005 17:46:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
    I've a server with 2 Operton 64bit CPU and 12G memory, and this server 
is used to run  applications which will comsume huge memory,
the problem is: when this aplications exits,  the free memory of the server 
is still very low(accroding to the output of "top"), and
from the output of command "free", I can see that many GB memory was cached 
by kernel. Does anyone know how to free the kernel cached
memory? thanks in advance.

Sincerely,
Ashley
------------------------------------------------------
AlChip Technologies, Limited
26F, Huamin Empire Plaza, Suite B-H,
726 West YanAn Road,
Shanghai, China 200050
Tel: 86-21-5237-8800 ext.220
Fax: 86-21-5237-8880
http://www.alchip.com
------------------------------------------------------  


