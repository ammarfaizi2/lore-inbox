Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317534AbSGJQ21>; Wed, 10 Jul 2002 12:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSGJQ20>; Wed, 10 Jul 2002 12:28:26 -0400
Received: from pD952A32F.dip.t-dialin.net ([217.82.163.47]:57216 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317534AbSGJQ2Z>; Wed, 10 Jul 2002 12:28:25 -0400
Date: Wed, 10 Jul 2002 10:31:05 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Adrian Bunk <bunk@fs.tum.de>
cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  July 10, 2002
In-Reply-To: <Pine.NEB.4.44.0207101816190.24665-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0207101027380.5067-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Jul 2002, Adrian Bunk wrote:
> Are there any reasons why these don't make it into 2.5?
> 
> >    - Better event logging for enterprise systems

Linus was scared we could break old syslog parsers.

> >    - Linux booting ELF images

Reason unknown. I expect some statement here.

> >    - First pass at LinuxBIOS support

Possibly no one had one? I have some boxes running prettily on LinuxBIOS, 
can't imagine why it isn't merged into 2.5. But I can't imagine what's 
speaking against KBuild-2.5 either. I can speak it, I love it.

> >    - Build option for Linux Trace Toolkit (LTT)

Nobody seemed to be interested in this toolkit. The (s|l)trace toolkit and 
kdb seemed to be sufficient for the most developers. (I don't whine here 
either.)

> >    - Scalable CPU bitmasks

Seems they got lost.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

