Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317032AbSEWWH2>; Thu, 23 May 2002 18:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317033AbSEWWH1>; Thu, 23 May 2002 18:07:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3591 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317032AbSEWWH0>;
	Thu, 23 May 2002 18:07:26 -0400
Message-ID: <3CED593D.5070903@evision-ventures.com>
Date: Thu, 23 May 2002 23:03:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Mark Gross <mgross@unix-os.sc.intel.com>,
        "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
        "Gross, Mark" <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:
    PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <200205220748.g4M7mc2157646@northrelay01.pok.ibm.com> <20020522141747.G37@toy.ucw.cz> <200205222043.g4MKhsw06808@unix-os.sc.intel.com> <20020522192202.D229@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> swsusp definitely is usable on SMP system. Take server with not-hotpluggable
> pci andpci card you want to add. How do you add it with minimum impact on
> users?
> 
> suspend/add card/resume
> 									Pavel
> PS: I did not yet test swsusp on SMP, through. But I'd like it to work.

And BOFH type system admins can use it to never ever make changes to the
systems configuration by duplicating them in boot scripts...
route add ... and ifconfig eth0 come first to my mind :-).

