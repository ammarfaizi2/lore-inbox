Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSFRJTJ>; Tue, 18 Jun 2002 05:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSFRJTJ>; Tue, 18 Jun 2002 05:19:09 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:40401 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S317366AbSFRJTI>; Tue, 18 Jun 2002 05:19:08 -0400
Message-ID: <3D0EFB35.1030606@nospam.com>
Date: Tue, 18 Jun 2002 18:19:49 +0900
From: Hugh <hugh@nospam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: core@enodev.com, linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon 2000 XP MP nightmare
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>XP MPs exist now.
>
>--
>Shawn Leas
>core@enodev.com

It is all so confusing.  I see two MP 1900+ as "POST"
While linux is booting up, it shows AMD 1900+ XP's, then
after a lot of booting log, I see

ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
... changing IO-APIC ID 2 ... ok
TIMER: vector=0x31 pin1=2 pint2=0


Then, nothing.  It stops completely.
What is going on?


Secondly, what CPUs do I really have?  MP enabled or not?

Thanks

G. Hugh Song

