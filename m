Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271958AbRIDMLd>; Tue, 4 Sep 2001 08:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271959AbRIDMLX>; Tue, 4 Sep 2001 08:11:23 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:1108 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S271958AbRIDMLP>; Tue, 4 Sep 2001 08:11:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Patrick Dreker <patrick@dreker.de>
Organization: Chaos Inc.
To: Tim Waugh <twaugh@redhat.com>
Subject: Re: lpr to HP laserjet stalls
Date: Tue, 4 Sep 2001 14:07:07 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Michael Ben-Gershon <mybg@netvision.net.il>, linux-kernel@vger.kernel.org
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <E15e4WO-0007uH-00@wintermute> <20010904095042.N20060@redhat.com>
In-Reply-To: <20010904095042.N20060@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15eEz3-0000GU-00@wintermute>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 04 September 2001 10:50 schrieb Tim Waugh:
> On Tue, Sep 04, 2001 at 02:56:56AM +0200, Patrick Dreker wrote:
> > All of this vanished, when I replaced all occurrences of /dev/lp0 in my
> > printer configuration by /dev/par0. I has been working flawlessly since
> > then.
>
> crw-rw----    1 root     lp         6,   0 Aug 30 21:30 /dev/lp0
> crw-------    1 root     root       6,   0 Aug 30 21:30 /dev/par0
>
> Are you sure you didn't also upgrade the kernel? ;-)
I must have been through approx. 20-30 Kernel Versions since that time 
(including some -test, -pre and -ac versions), so I would not rule out that 
possibility. Especially since I have not been able to reproduce this in the 
last few hours, and I must say, that I have really tried to ;-)

> Tim.
> */

-- 
Patrick Dreker
---------------------------------------------------------------------
> Is there anything else I can contribute?
The latitude and longtitude of the bios writers current position, and
a ballistic missile.        
                         Alan Cox on linux-kernel@vger.kernel.org
