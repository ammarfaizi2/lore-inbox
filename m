Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270111AbRHGHFo>; Tue, 7 Aug 2001 03:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270112AbRHGHFf>; Tue, 7 Aug 2001 03:05:35 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:15309 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S270111AbRHGHFZ>;
	Tue, 7 Aug 2001 03:05:25 -0400
Message-Id: <200108070705.f7775xl27094@www.2ka.mipt.ru>
Date: Tue, 7 Aug 2001 11:08:38 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: Ryan Mack <rmack@mackman.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.4.33.0108062338130.5491-100000@mackman.net>
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru>
	<Pine.LNX.4.33.0108062338130.5491-100000@mackman.net>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.7-ac7; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Mon, 6 Aug 2001 23:45:33 -0700 (PDT)
Ryan Mack <rmack@mackman.net> wrote:

>> Hmmm, let us suppose, that i copy your crypted partition per bit to my
>> disk.
>> After it I will disassemble your decrypt programm and will find a key....
>>
>> In any case, if anyone have crypted data, he MUST decrypt them.
>> And for it he MUST have some key.
>> If this is a software key, it MUST NOT be encrypted( it's obviously,
>> becouse in other case, what will decrypt this key?) and anyone, who have
>> PHYSICAL access to the machine, can get this key.
>> Am I wrong?

RM> I think the point you are missing is that encrypted swap only needs to be
RM> accessible for one power cycle.  Thus the computer can generate a key at
No, computer can not do this.
This will do some program,and this program is not crypted.
Yes?
We disassemle this program, get algorithm and regenerate a key in evil machine?
Am i wrong?

P.S. off-topic What algorithm do you want to use to regenerate a key for once crypted data?
I don't know anyone, or i can't understand your point of view.

RM> -Ryan

---
WBR. //s0mbre
