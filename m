Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRDUAUk>; Fri, 20 Apr 2001 20:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132313AbRDUAUa>; Fri, 20 Apr 2001 20:20:30 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:42246 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S132301AbRDUAUT>; Fri, 20 Apr 2001 20:20:19 -0400
Message-ID: <3AE0D3DC.5050009@eisenstein.dk>
Date: Sat, 21 Apr 2001 02:27:08 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 'make dep' warning with 2.4.3 : computed checksums did NOT match
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While compiling a 2.4.3 kernel on my Slackware 7.1 box (heavily updated 
to have the correct utils and so on) I noticed a warning during 'make dep'.

This is the exact message:

make[6]: Leaving directory /usr/src/linux-2.4.3/drivers/isdn/eicon'
make -C hisax fastdep
md5sum: WARNING: 12 of 12 computed checksums did NOT match
make[6]: Entering directory /usr/src/linux-2.4.3/drivers/isdn/hisax'

I'm not using any of the isdn stuff, so I'm not really worried about 
this, but I thought I'd report it anyway since 'someone more 
knowledgeable than me (TM)' might find it important...


Best regards,
Jesper Juhl - juhl@eisenstein.dk

