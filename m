Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbSLEPpB>; Thu, 5 Dec 2002 10:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbSLEPpA>; Thu, 5 Dec 2002 10:45:00 -0500
Received: from earth.colorado-research.com ([65.171.192.8]:63154 "EHLO
	earth.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267337AbSLEPpA>; Thu, 5 Dec 2002 10:45:00 -0500
Message-ID: <3DEF763E.1050302@cora.nwra.com>
Date: Thu, 05 Dec 2002 08:52:30 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS - IRIX client issues
References: <3DEE85D3.6070009@cora.nwra.com> <3DEE8EC2.2040305@rackable.com> <3DEE9425.40204@cora.nwra.com> <20021205051507.GA17498@ip68-4-86-174.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:

>I'm having the same problem, with Solaris 8 on SPARC for the NFS server
>(as opposed to Linux), on one of my machines. For some reason it only
>happens when it's plugged into a 100MBps Netgear non-switching (i.e, "old
>fashioned" in a sense -- half-duplex) hub. If I plug it straight into
>the wall at work (this is connected directly to a 10MBps (I know),
>full-duplex (I think) port on some kind of switch whose other details I
>have no idea about), the problem instantly disappears.
>
>At least, I think it's the same problem. When your connection collapses,
>does IRIX complain about timeouts trying to contact the NFS server,
>almost as if the NFS server fell off the face of the planet?
>  
>
Actually, I get exactly zero in the logs and aparently zero NFS traffic 
arriving at the server, so we may have different problems.

Thanks for the support links, but unfortunately I'm basically in the 
same situation - support cancelled in the belief we will eventually move 
completely to linux (though for now the SGI is our only large memory 
64-bit platform).

- Orion


