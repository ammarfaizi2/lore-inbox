Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282136AbRK1Mch>; Wed, 28 Nov 2001 07:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282138AbRK1Mc1>; Wed, 28 Nov 2001 07:32:27 -0500
Received: from andromeda.veritel.com.br ([200.230.193.1]:40155 "HELO
	veritel.com.br") by vger.kernel.org with SMTP id <S282136AbRK1McK>;
	Wed, 28 Nov 2001 07:32:10 -0500
Message-ID: <3C04DA1C.8080304@veritel.com.br>
Date: Wed, 28 Nov 2001 10:35:40 -0200
From: "William N. Zanatta" <william@veritel.com.br>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ Kernel Panic - 2.4.14 ] - Attempted to kill the idle task!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  Last night, after booting my machine, I just mounted my ZIP disk and 
after a 'ls -la /mnt ', I got an Oops with the message "Attempted to 
kill the idle task!".
  It didn't happen before since I compiled 2.4.14. It always happened 
when I was running 2.4.5 (which is the one that comes in Slack 8 distro).

  Hardware:
    - Athlon 1.2Ghz
    - Abit KT7A-R (with the famous and still not well supported VIA chipset)
    - 256Mb RAM
    - NEC IDE Zip Drive

  Maybe it's something related to the processor as I got messages like 
that when using 2.4.5 which has a buggy microcode for AMD.
  Any stuff or tips on this???

  Thank you,

William

