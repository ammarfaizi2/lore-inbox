Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263757AbUDQJsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 05:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbUDQJsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 05:48:54 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:61709
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263757AbUDQJsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:48:51 -0400
Date: Sat, 17 Apr 2004 02:46:24 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Willy Tarreau <w@w.ods.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
In-Reply-To: <20040416205028.GC596@alpha.home.local>
Message-ID: <Pine.LNX.4.10.10404170244230.22035-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Willy,

I do not drink.  I have enough trouble keeping friends when I am sobber.
Sheesh, I worked for Merkey before and drinking and posting is a bad idea.

Point being, it was not important in the beginning ... so it is not
important now.  Being consistant is one thing I have always been.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 16 Apr 2004, Willy Tarreau wrote:

> > Marcelo,
> > 
> > You are suggesting that 2.6 is not stable ?  How could that be ?
> 
> Andre, ressure me, you were drunk ?
> 
> A stable kernel is a kernel in which a new release does not induce 20 rejects
> when applying the same patches as on the previous one, and in which you can
> confidently upgrade to fix a security issue without worrying that everything
> else will break under your feet. I'm really happy that 2.4 *WILL* become
> stable with 2.4.27, and probably will be the first 2.4 kernel ready for far
> remote deployment. Since about 2.4.23, it has become a lot easier to maintain
> up-to-date parallel trees in sync with Marcelo's because of less core changes
> all the time, and I really thank him for this progressive feature freeze.
> When I'll have a fair insurance that 2.6 does not change so fast, may be I'll
> start to think about it. But right now, 2.6 only serves me as a boot loader
> in conjunction with Randy's kexec patch. Sad but true.
> 
> > Should it not be backported to 2.2 and why not 2.0 ?
> 
> I thought you were more aware than that about the number of people still
> using 2.0 and 2.2. They are "a lot". What does "a lot" mean ? Well, I think
> that there are more people still running production machines on 2.2 and 2.0
> than people who have ever used 1.0 or 1.2. And at these times, we considered
> that "a lot". I know some people who still install RedHat 6.2 from time to
> time. Why do they do this ? certainly because a standard 2.2.26 kernel +
> grsecurity offers them enough stability and security to satisfy their needs
> and not to have to upgrade every 4 months.
> 
> > Necessary? But their is the new and improved called 2.6.
> > It is time for the old and lousy to quietly wimper off and die.
> 
> I would better say that it's time for the old and stable to live long and
> quitely, and for the young baby to slowly discover the desktop world, then
> the production world before engaging its reputation on mission-critical
> systems.
> 
> Regards,
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

