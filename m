Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284914AbRLPX0S>; Sun, 16 Dec 2001 18:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284916AbRLPX0I>; Sun, 16 Dec 2001 18:26:08 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:60544 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S284914AbRLPXZx>; Sun, 16 Dec 2001 18:25:53 -0500
To: adam@tabris.net, raul@viadomus.com, rml@tech9.net
Subject: Re: Is /dev/shm needed?
Cc: linux-kernel@vger.kernel.org
Message-Id: <E16Fkqc-0001Z0-00@DervishD.viadomus.com>
Date: Mon, 17 Dec 2001 00:37:34 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Adam :))

>> have lots of memory to spare, give it a try.  Mount /tmp or all of /var
>> in tmpfs.
>Unfortunately, some(many?) distros are b0rken in re /var/. There is
>stuff put there that is needed across boots (for example, mandrake
>puts the DNS master files in /var/named.)

    Moreover, didn't the LHS say that /var/tmp is supposed to be
maintained across reboots? I'm not sure about this, but anyway /var
is supposed to hold temporary data, not boot-throwable data, isn't
it?

    Raúl
