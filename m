Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130929AbRCFFDm>; Tue, 6 Mar 2001 00:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130931AbRCFFDc>; Tue, 6 Mar 2001 00:03:32 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:37325 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130929AbRCFFDS>; Tue, 6 Mar 2001 00:03:18 -0500
Message-ID: <3AA46E63.69A80EB3@coplanar.net>
Date: Mon, 05 Mar 2001 23:58:11 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: steve.snyder@philips.com
CC: linux-kernel@vger.kernel.org
Subject: Re: How-To for PPPoE in v2.4.x?
In-Reply-To: <0056910010694057000002L172*@MHS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steve.snyder@philips.com wrote:

> Is there a How-To for getting the Linux v2.4.x PPPoE support to work?
> I've searched for info but have mostly found sketchy references on getting
> PPPoE to work with the v2.2 kernel.
>

I have been using PPPoE in the 2.4.0 kernel for about 2 months now.  It's
very nice.  I used

http://www.math.uwaterloo.ca/~mostrows/

just grab the tarball and compile.  I bet it will work under 2.4.2 also.

>
> My system is running RedHat v6.2 and the v2.4.2 Linux kernel.  I've built
> PPP and PPPoE support into the kernel and I've installed the v2.4.0 PPP
> software.  I've got the /dev/ppp created by the RedHat installation and I
> see "pppoe" in the /proc/drivers list of drivers.
>
> I've got a (PCMCIA-based) NIC that I know works as a plain non-PPPoE
> device under v2.4.x.
>
> So what do I do now?  Do I have to patch pppd to utilize the kernel's
> new PPPoE support?  Do I have to create a /dev/pppoe devnode?
>
> While I have a lot of experience with Ethernet networking on Linux, I am a
> total PPP (let alone PPPoE) newbie.  Please be gentle.  :-)

