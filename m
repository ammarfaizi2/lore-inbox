Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbQLEXyJ>; Tue, 5 Dec 2000 18:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbQLEXxt>; Tue, 5 Dec 2000 18:53:49 -0500
Received: from jalon.able.es ([212.97.163.2]:24769 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129210AbQLEXxm>;
	Tue, 5 Dec 2000 18:53:42 -0500
Date: Wed, 6 Dec 2000 00:23:00 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PM in 2.2
Message-ID: <20001206002300.C1550@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001205001917.A718@werewolf.able.es> <Pine.LNX.4.10.10012041854040.26513-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.10.10012041854040.26513-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Tue, Dec 05, 2000 at 00:54:43 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Dec 2000 00:54:43 Mark Hahn wrote:
> > I would like to know if there is any back-port of ACPI to 2.2.
> > Problem: 2-way machine, so APM does not work.
> > I would love my box powers down when I shutdown...just like macs.
> 
> APM power-off works in SMP.  though I know only about modern kernels,
> not grotesquely obsolete ones like 2.2 ;)

Thanks, 'append="apm=power-off"' worked in my 'oldie' 2.2.18-pre24.
This is beginning to look like a real computer...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre24-vm #2 SMP Wed Nov 29 02:56:21 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
