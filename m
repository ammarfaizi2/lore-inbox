Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSKHNpu>; Fri, 8 Nov 2002 08:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSKHNpu>; Fri, 8 Nov 2002 08:45:50 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:47881
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261978AbSKHNpt>; Fri, 8 Nov 2002 08:45:49 -0500
Date: Fri, 8 Nov 2002 08:51:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: ricklind@us.ibm.com, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.46: duplicate statistics being gathered 
In-Reply-To: <Pine.LNX.3.95.1021108083018.12615A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0211080850120.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Richard B. Johnson wrote:

> On Fri, 8 Nov 2002, Rick Lindsley wrote:
> 
> >     The <unknown quantity of> applications out there which are reading
> >     the disk info from /proc/stat need to be taught to go fishing in
> >     /name-of-the-day-fs.
> > 
> 
> There is /proc/version, which could have been used to make
> `ps` and `top` compatable over, at least previously known
> versions.
> 
> The last version of procps I have a copy of is 1.2. I don't see
> anybody opening that file anywhere. Maybe it would be a good
> idea to start.

...
munmap(0x40013000, 113429)              = 0
uname({sys="Linux", node="montezuma.mastecende.com", ...}) = 0
open("/proc/uptime", O_RDONLY)          = 3
lseek(3, 0, SEEK_SET)                   = 0
..

? Or is this not what you had in mind.

	Zwane
-- 
function.linuxpower.ca

