Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265360AbRFVHW2>; Fri, 22 Jun 2001 03:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbRFVHWS>; Fri, 22 Jun 2001 03:22:18 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14086 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265360AbRFVHWO>; Fri, 22 Jun 2001 03:22:14 -0400
Message-ID: <3B32F1BA.C43BBE8A@idb.hist.no>
Date: Fri, 22 Jun 2001 09:20:26 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Thomas Weber <x@abyss.4t2.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.6pre iptables masquerading seems to kill eth0
In-Reply-To: <3B31A652.85D2E597@idb.hist.no> <9gtmol$9ve$1@pandemonium.abyss.4t2.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Weber wrote:
> 
> I'm on 2.4.6pre3 + freeswan/ipsec on my gateway now for 5 days.
> It's an old 486/66 32MB with several isdn links, a dsl uplink (with
> iptables masquerading) behind a ne2k clone and a 3c509 to the inside network.
> no problems at all with the interfaces (all compiled as modules).

Nice to know it works for you.  The troubled machine is a dual celeron, 
so it could be some sort of SMP problem.  I am trying pre5
to see if it is better, I'll probably know in a few days.

Helge Hafting
