Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279505AbRJZXbd>; Fri, 26 Oct 2001 19:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279514AbRJZXbO>; Fri, 26 Oct 2001 19:31:14 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:27920 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S279505AbRJZXbJ>;
	Fri, 26 Oct 2001 19:31:09 -0400
Message-ID: <3BD9F2A7.5010501@si.rr.com>
Date: Fri, 26 Oct 2001 19:32:55 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.13-ac2: i82092.c compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   I have seen the below posted yet for 13-ac2.
     During 'make bzImage', I received the following error:
In file included from i82092.c:25:
i82092aa.h:14: warning: invalid character in macro parameter name
i82092aa.h:14: badly punctuated parameter list in '#define'
i82092.c:  In function 'i82092aa_pci_probe':
i82092.c:137: warning: implicit declaration of function 'dprintk'
make[3]: ***[i82092.o] Error 1
make[3]: Leaving directory '/usr/src/linux/drivers/pcmcia'

Regards,
Frank

