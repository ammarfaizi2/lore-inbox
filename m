Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269210AbTCBBJp>; Sat, 1 Mar 2003 20:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269211AbTCBBJp>; Sat, 1 Mar 2003 20:09:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269210AbTCBBJo>;
	Sat, 1 Mar 2003 20:09:44 -0500
Message-ID: <3E615C38.7030609@pobox.com>
Date: Sat, 01 Mar 2003 20:19:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arador <diegocg@teleline.es>, "Adam J. Richter" <adam@yggdrasil.com>,
       andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
References: <200303020011.QAA13450@adam.yggdrasil.com>	 <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1046571336.24903.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sun, 2003-03-02 at 00:49, Arador wrote:
> 
>>On Sat, 1 Mar 2003 16:11:55 -0800
>>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>
>>(Just a very personal suggestion)
>>Why to waste time trying to clone a 
>>tool such as bitkeeper? Why not to support things like subversion?
> 
> 
> Because the repositories people need to read are in BK format, for better
> or worse. It doesn't ultimately matter if you use it as an input filter
> for CVS, subversion or no VCS at all.

"BK format"?  Not really.  Patches have been posted (to lkml, even) to 
GNU CSSC which allow it to read SCCS files BK reads and writes.

Since that already exists, a full BitKeeper clone is IMO a bit silly, 
because it draws users and programmers away from projects that could 
potentially _replace_ BitKeeper.

	Jeff



