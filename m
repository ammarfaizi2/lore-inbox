Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTI1DQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 23:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTI1DQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 23:16:56 -0400
Received: from miranda.zianet.com ([216.234.192.169]:47631 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S262312AbTI1DQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 23:16:55 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Paul Jakma <paul@clubi.ie>, Larry McVoy <lm@bitmover.com>
Subject: Re: Scaling noise
Date: Sat, 27 Sep 2003 21:13:17 -0600
User-Agent: KMail/1.5
Cc: Timothy Miller <miller@techsource.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com> <20030910151238.GC32321@work.bitmover.com> <Pine.LNX.4.56.0309280249030.19081@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.56.0309280249030.19081@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309272113.18030.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 September 2003 07:51 pm, Paul Jakma wrote:
> On Wed, 10 Sep 2003, Larry McVoy wrote:
> > Dave and friends can protest as much as they want that the kernel works
> > and it scales (it does work, it doesn't scale by comparison to something
> > like IRIX)
>
> Aside: Might want to tell SGI as their new ccNUMA Altrix line (Origin
> 3k with Itanic instead of MIPS i think) run Linux!

Since Larry is off doing other things for the next week and a half, I'll attemt to
to answer that for him.  Larry was possibly referring to IRIX scaling to 1024 CPUs,
e.g. the "Chapman" machine, mentioned here:
http://www.sgi.com/company_info/awards/03_computerworld.html

It appears that SGI is working to scale the Altix to 128 CPUs on Linux.
http://marc.theaimsgroup.com/?l=linux-kernel&m=106323064611280&w=2

Steven
