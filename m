Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSLHBPl>; Sat, 7 Dec 2002 20:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSLHBPl>; Sat, 7 Dec 2002 20:15:41 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:49110 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S265081AbSLHBPk>;
	Sat, 7 Dec 2002 20:15:40 -0500
Date: Sun, 8 Dec 2002 02:22:58 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.20-BK
Message-ID: <20021208012258.GB5355@werewolf.able.es>
References: <200212071434.11514.m.c.p@wolk-project.de> <1039312291.27923.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1039312291.27923.13.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Dec 08, 2002 at 02:51:31 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.08 Alan Cox wrote:
>On Sat, 2002-12-07 at 13:35, Marc-Christian Petersen wrote:
>> Hi Alan,
>> 
>> using 2.4.20-BK tree gives me:
>> 
>> flushing ide devices: hda hdd
>
>Marcelo dropped some of the patches I sent (or his mailer or some random
>box in between did). You also want the ll_rw_blk change from -ac
>

BTW, sometimes i noticed that my box powers of after

flushing ide devices: hda hdb hdc hdd

and others I just see a couple disks and then power-off in the middle
of the flush message. Is this something known ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
