Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282640AbRKZXPq>; Mon, 26 Nov 2001 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282643AbRKZXPg>; Mon, 26 Nov 2001 18:15:36 -0500
Received: from jalon.able.es ([212.97.163.2]:43231 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S282640AbRKZXP3>;
	Mon, 26 Nov 2001 18:15:29 -0500
Date: Tue, 27 Nov 2001 00:15:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Message-ID: <20011127001518.A1546@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.BSF.4.30.0111261836000.77704-100000@noc.zabbadoz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.BSF.4.30.0111261836000.77704-100000@noc.zabbadoz.net>; from bzeeb+linuxkernel@zabbadoz.net on Mon, Nov 26, 2001 at 19:48:12 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011126 Bjoern A. Zeeb wrote:
>
>The problem is that you kernel hackers out there fetch the pre stuff
>and test it that others run test cycles on them ... .  But the
>lot of people out there will never fetch anything else than
>a "release" ; no -pre no -rc no -ac no whatever prefix or suffix.
>You will not get them just because somebody 's changing the name
>to something else.
>

The problem is the fear of people about -ac or -pre series. What should
be done is to teach people that what they think is kernel 2.4.8 from
RedHat or Mandrake is really 2.4.8-ac7 or the like. They are shipping
-ac versions (beacuse of preferences and driver update, usually are
-ac series and not -pre series). So your 'distro rock solid kernel'
is an -ac kernel (and I do not say that an -ac kernel is not rock
solid, I have run -ac's until 13-ac7).

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.16-pre1 #1 SMP Sun Nov 25 02:06:34 CET 2001 i686
