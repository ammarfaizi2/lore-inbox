Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276651AbRJHA1o>; Sun, 7 Oct 2001 20:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276718AbRJHA1e>; Sun, 7 Oct 2001 20:27:34 -0400
Received: from jalon.able.es ([212.97.163.2]:46068 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276651AbRJHA1Y>;
	Sun, 7 Oct 2001 20:27:24 -0400
Date: Mon, 8 Oct 2001 02:27:47 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: harri@synopsys.COM, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dan Hollis <goemon@anime.net>, linux-kernel@vger.kernel.org
Subject: Re: CPU Temperature?
Message-ID: <20011008022747.A26392@werewolf.able.es>
In-Reply-To: <3BC0191F.C0085955@Synopsys.COM> <E15qAsz-0005PE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15qAsz-0005PE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 07, 2001 at 12:10:17 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011007 Alan Cox wrote:
>> Of course I would be interested to get the lm_sensors included in the
>> kernel, too. Is this still an option for 2.4.x? 
>
>It doesnt break the machine, replace key parts of the core of the system or 
>change critical interfaces. By conventional standards its ok, by 2.4.10 
>standards its not a candidate 8)
>

Latest CVS release has even changed all the malloc includes to slabs, so 
is there any non-cosmetic problem ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.10-ac7-bproc #1 SMP Sat Oct 6 12:38:17 CEST 2001 i686
