Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288089AbSATVzZ>; Sun, 20 Jan 2002 16:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288460AbSATVzQ>; Sun, 20 Jan 2002 16:55:16 -0500
Received: from james.kalifornia.com ([208.179.59.2]:55420 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S288089AbSATVyk>; Sun, 20 Jan 2002 16:54:40 -0500
Message-ID: <3C4B3CA8.3090406@blue-labs.org>
Date: Sun, 20 Jan 2002 16:54:48 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compile err - 2.4.18-pre4 - undefined reference to `unload_mpu401'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/sound/sounddrivers.o: In function `unload_sbmpu':
drivers/sound/sounddrivers.o(.text+0xc0b3): undefined reference to 
`unload_mpu401'
drivers/sound/sounddrivers.o(__ksymtab+0x2d0): undefined reference to 
`unload_mpu401'
make: *** [vmlinux] Error 1

This is 2.4.18-pre4, any quick fixes?

-d


