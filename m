Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030907AbWKUMBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030907AbWKUMBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030911AbWKUMBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:01:12 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:28626 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1030907AbWKUMBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:01:10 -0500
Message-ID: <4562EAA9.8020102@web.de>
Date: Tue, 21 Nov 2006 13:01:45 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

rt4 runs fine. But while compiling 2.6.19-rc6-rt5 I get this error:

CC      mm/page_alloc.o
mm/page_alloc.c: In function 'page_alloc_init':
mm/page_alloc.c:2793: error: 'page_alloc_cpu_notify' undeclared (first use 
in this function)
mm/page_alloc.c:2793: error: (Each undeclared identifier is reported only once
mm/page_alloc.c:2793: error: for each function it appears in.)
make[1]: *** [mm/page_alloc.o] Error 1
make: *** [mm] Error 2

Regards,
Marcus

--
www.marcush.de
