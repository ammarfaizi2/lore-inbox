Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbTCaW7K>; Mon, 31 Mar 2003 17:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbTCaW7K>; Mon, 31 Mar 2003 17:59:10 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:464 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S261892AbTCaW7J>; Mon, 31 Mar 2003 17:59:09 -0500
Date: Mon, 31 Mar 2003 15:07:21 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030331230720.GP32000@ca-server1.us.oracle.com>
References: <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com> <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303312215020.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303312215020.5042-100000@serv>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 11:32:55PM +0200, Roman Zippel wrote:
> later. The ones who ask now for a larger dev_t the loudest are likely the 
> first to demand later not change anything for "compability", because they 
> hardcoded certain assumptions about dev_t into their applications.

	I'm right here campaigning loudly for a larger dev_t.  I intend
to never, ever make assumptions about dev_t.  In fact, I'd rather not
deal with dev_t.  But I do need a way to map 4k or 8k or 16k disks.
now.

Joel

-- 

"Up and down that road in our worn out shoes,
 Talking bout good things and singing the blues."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
