Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312944AbSDSX1u>; Fri, 19 Apr 2002 19:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312076AbSDSX1q>; Fri, 19 Apr 2002 19:27:46 -0400
Received: from jalon.able.es ([212.97.163.2]:40844 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314525AbSDSX0p>;
	Fri, 19 Apr 2002 19:26:45 -0400
Date: Sat, 20 Apr 2002 01:26:33 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Heinz Diehl <hd@cavy.de>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1, -jam2
Message-ID: <20020419232633.GA1775@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.10.10204161720260.10691-100000@master.linux-ide.org> <20020417134004.GA2025@werewolf.able.es> <20020418081152.GA559@chiara.cavy.de> <20020418192728.GA1891@werewolf.able.es> <20020419140520.GA1687@chiara.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.19 Heinz Diehl wrote:
>On Thu Apr 18 2002, J.A. Magallon wrote:
>
>> >I also changed '#if 1' to '#if 0' as Andre mentioned but it has no effect,
>> >my machine hangs at boot time....
>
>> It worked for me, just booted fine with hdparm included...
>
>I just merged "ide-2.4.19-p7.all.convert.5.patch" into my tree, and now
>it works also for me. With former versions my machine hung at boot time,
>wether #if 0 or 1 was set.
>

Just a 'me too'. Patch -5 booted fine, I have put a -jam2 in the usual place:


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam2 #1 SMP sáb abr 20 00:20:15 CEST 2002 i686
