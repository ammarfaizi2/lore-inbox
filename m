Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbRCWNQ6>; Fri, 23 Mar 2001 08:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbRCWNQj>; Fri, 23 Mar 2001 08:16:39 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:35338 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130779AbRCWNQb>;
	Fri, 23 Mar 2001 08:16:31 -0500
Date: Fri, 23 Mar 2001 14:15:47 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Modem and sound support question..
To: jorgp@bartnet.net, linux-kernel@vger.kernel.org
Message-id: <3ABB4C83.E153C04C@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JorgP (jorgp@bartnet.net) wrote 

> Lucent Microelectronics 56k WinModem s (rev 01) 
> VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 50) 
> 
> are either or both support by 2.4 kernel? If so, what modules need to be 
> loaded? 

For VIA audio , load the via82cxxx_audio module.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
