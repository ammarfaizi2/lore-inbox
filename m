Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSDRT1h>; Thu, 18 Apr 2002 15:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314434AbSDRT1g>; Thu, 18 Apr 2002 15:27:36 -0400
Received: from jalon.able.es ([212.97.163.2]:52617 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314433AbSDRT1f>;
	Thu, 18 Apr 2002 15:27:35 -0400
Date: Thu, 18 Apr 2002 21:27:28 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Heinz Diehl <hd@cavy.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Message-ID: <20020418192728.GA1891@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.10.10204161720260.10691-100000@master.linux-ide.org> <20020417134004.GA2025@werewolf.able.es> <20020418081152.GA559@chiara.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.18 Heinz Diehl wrote:
>On Wed Apr 17 2002, J.A. Magallon wrote:
>
>> Can it be related to my system getting hung on boot trying to do
>> an hdparm ?
>
>Yep, here it is exactly the same.
>
>I also changed '#if 1' to '#if 0' as Andre mentioned but it has no effect,
>my machine hangs at boot time....
>

It worked for me, just booted fine with hdparm included...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam1 #2 SMP Wed Apr 17 21:20:31 CEST 2002 i686
