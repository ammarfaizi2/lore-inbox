Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSANO5r>; Mon, 14 Jan 2002 09:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289260AbSANO5b>; Mon, 14 Jan 2002 09:57:31 -0500
Received: from jalon.able.es ([212.97.163.2]:52733 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289255AbSANO5X>;
	Mon, 14 Jan 2002 09:57:23 -0500
Date: Mon, 14 Jan 2002 16:02:56 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, zippel@linux-m68k.org, rml@tech9.net,
        ken@canit.se, arjan@fenrus.demon.nl, landley@trommello.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114160256.A2922@werewolf.able.es>
In-Reply-To: <200201140033.BAA04292@webserver.ithnet.com> <E16PvKx-00005L-00@the-village.bc.nu> <20020114104532.59950d86.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020114104532.59950d86.skraw@ithnet.com>; from skraw@ithnet.com on lun, ene 14, 2002 at 10:45:32 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020114 Stephan von Krawczynski wrote:
>
>Hm, obviously the ll-patches look simple, but their pure required number makes
>me think they are as well stupid as simple. This whole story looks like making
>an old mac do real multitasking, just spread around scheduling points

Yup. That remind me of...
Would there be any kernel call every driver is doing just to hide there
a conditional_schedule() so everyone does it even without knowledge of it ?
Just like Apple put the SystemTask() inside GetNextEvent()...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre3-beo #5 SMP Sun Jan 13 02:14:04 CET 2002 i686
