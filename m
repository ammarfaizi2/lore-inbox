Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbRCGJES>; Wed, 7 Mar 2001 04:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130488AbRCGJEI>; Wed, 7 Mar 2001 04:04:08 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:5126 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130453AbRCGJDv>; Wed, 7 Mar 2001 04:03:51 -0500
Message-ID: <3AA5F8E1.AC570516@idb.hist.no>
Date: Wed, 07 Mar 2001 10:01:21 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: Process vs. Threads
In-Reply-To: <20010306172843.D1283@hpspss3g.spain.hp.com> <20010306115822.A2244@xi.linuxpower.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

> 
> There are no threads in Linux.
> All tasks are processes.
> Processes can share any or none of a vast set of resources.
> 
Is there a way a user program can find out what resources 
are shared among which processes? 

That would allow enhancing ps, top, etc to
report memory usage correctly.

Helge Hafting
