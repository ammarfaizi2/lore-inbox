Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272299AbRH3QFW>; Thu, 30 Aug 2001 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272298AbRH3QFM>; Thu, 30 Aug 2001 12:05:12 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:40454 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S272299AbRH3QFA>;
	Thu, 30 Aug 2001 12:05:00 -0400
Message-ID: <3B8E6467.1030204@si.rr.com>
Date: Thu, 30 Aug 2001 12:05:59 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.9-ac4: undefined reference pgtable_cache_init
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   During make bzImage, I received the following:

init/main.o: In function 'start_kernel'
init/main.o(.text.init+0x842): undefined reference to 'pgtable_cache_init'
make: *** [vmlinux] Error 1

Regards,
Frank

