Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTEIQaT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTEIQaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:30:19 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:64960 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263303AbTEIQaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:30:18 -0400
Message-ID: <3EBBDA0A.2010709@blue-labs.org>
Date: Fri, 09 May 2003 12:40:42 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: #include error (userland)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from /usr/include/netinet/igmp.h:26,
                 from /usr/include/libnet.h:69,
                 from killtcp.c:6:
/usr/include/linux/igmp.h:74:2: #error "Please fix <asm/byteorder.h>"
make[1]: *** [killtcp.o] Error 1


What needs to be fixed?

David


