Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVAUOXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVAUOXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVAUOXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:23:05 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:34997 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S262371AbVAUOXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:23:00 -0500
Date: Fri, 21 Jan 2005 15:22:59 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: zhilla <zhilla@spymac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ps/2 mouse going crazy
Message-ID: <20050121152259.6b186036@phoebee>
In-Reply-To: <41F10CBC.5000307@spymac.com>
References: <41F10CBC.5000307@spymac.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 15:07:56 +0100
zhilla <zhilla@spymac.com> bubbled:

> well, i have this funny problem, googled around a bit, and found a
> same  problem here, on the list, several days ago:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110579505706542&w=2
> so, just to inform you, guy is not imagining things, problem exists
> and  is quite annoying. happends every 2-3 hours?!
> 
> # dmesg | grep -i mouse
> mice: PS/2 mouse device common for all mice
> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> psmouse.c: bad data from KBC - bad parity
> psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost
> synchronization,  throwing 3 bytes away.
> 

Hmm, I have similar problems with my mouse since I'm using kernel 2.6.

Sometimes (once a day or only every second day) my mouse goes to the
left upper corner. But then works a normal. Extremly annoying while
playing UT2004.

But I don't get any kernel messages. With 2.4 everything worked fine.
(Currently using 2.6.8-rc2-mm1)


Regards,
Martin

-- 
MyExcuse:
Bad user karma.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
