Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbTCIBfz>; Sat, 8 Mar 2003 20:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbTCIBfz>; Sat, 8 Mar 2003 20:35:55 -0500
Received: from terminus.zytor.com ([63.209.29.3]:49335 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S262334AbTCIBfy>; Sat, 8 Mar 2003 20:35:54 -0500
Message-ID: <3E6A9CE4.9090801@zytor.com>
Date: Sat, 08 Mar 2003 17:46:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>	<20030307233916.Q17492@flint.arm.linux.org.uk>	<m1d6l2lih9.fsf@frodo.biederman.org>	<20030308100359.A27153@flint.arm.linux.org.uk>	<m18yvpluw7.fsf@frodo.biederman.org> <3E6A5C44.9060002@zytor.com> <m1n0k5jpit.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> Of course it is worth noting that PXE runtime support on the itanium
> does not even resemble PXE runtime support on x86.  Unlike unix it
> does not have a stable API.
> 

That doesn't surprise me.  Of course, that doesn't change my opinion 
about Itanic in any way :)

	-hpa


