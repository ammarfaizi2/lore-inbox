Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTCELkj>; Wed, 5 Mar 2003 06:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTCELkj>; Wed, 5 Mar 2003 06:40:39 -0500
Received: from pechkin.minfin.bg ([212.122.164.10]:37574 "EHLO
	pechkin.minfin.bg") by vger.kernel.org with ESMTP
	id <S265523AbTCELki>; Wed, 5 Mar 2003 06:40:38 -0500
Message-ID: <3E65E45E.8090401@minfin.bg>
Date: Wed, 05 Mar 2003 13:49:50 +0200
From: Kostadin Karaivanov <larry@minfin.bg>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030112
X-Accept-Language: en-us, en, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ipsec-tools 0.1 + kernel 2.5.64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>both manual keying and automatic keying with racoon (pre-shared secret)
>are working fine. No need to patch or modify anything. 
>I tried only ipv4.
>
>But: don't "setkey -DP" while racoon is running, it crashes
>my machine. Sorry, could not get any details.
This problem is present for me since 2.5.59, but once I get kernel oops
right after "setkey -DP" and before crash, it is on real tty not ssh or telnet,
on ssh/telnet console there is nothing exept freeze of course :-), I never tried 
serial console to catch the oops
>
>Andreas
BTW "ipsec-tools 0.1" from where ???

wwell Larry


