Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269252AbTCBRSQ>; Sun, 2 Mar 2003 12:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269253AbTCBRSP>; Sun, 2 Mar 2003 12:18:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269252AbTCBRSO>;
	Sun, 2 Mar 2003 12:18:14 -0500
Message-ID: <3E623F37.6060005@pobox.com>
Date: Sun, 02 Mar 2003 12:28:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <20030302020907.GE1364@dualathlon.random>
In-Reply-To: <20030302020907.GE1364@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Sat, Mar 01, 2003 at 08:45:08PM -0500, Jeff Garzik wrote:
> 
>>Andrea Arcangeli wrote:
>>
>>>Jeff, please uninstall *notrademarkhere* from your harddisk, install the
>>>patched CSSC instead (like I just did), rsync Rik's SCCS tree on your
>>>harddisk (like I just did), and then send me via email the diff of the
>>>last Changeset that Linus applied to his tree with author, date,
>>>comments etc...  If you can do that, you're completely right and at
>>>least personally I will agree 100% with you, again: iff you can.
>>
>>
>>You're missing the point:
>>
>>A BK exporter is useful.  A BK clone is not.
>>
>>If Pavel is _not_ attempting to clone BK, then I retract my arguments. :)
> 
> 
> hey, in your previous email you claimed all we need is the patched CSSC,
> you change topic quick! Glad you agree CSSC alone is useless and to make
> anything useful with Rik's *notrademarkhere* tree we need a true
> *notrademarkhere* exporter (of course the exporter will be backed by
> CSSC to extract the single file changes, since they're in SCCS format
> and it would be pointless to reinvent the wheel).

I have not changed the topic, you are still missing my point.

Let us get this small point out of the way:  I agree that GNU CSSC 
cannot read the BitKeeper ChangeSet file, which is a file critical for 
getting the "weave" correct.

But that point is not relevant to my thread of discussion.

Let us continue in the below paragraph...


> Now you say the bitbucket project (you read Pavel's announcement, he
> said "read only for now", that means exporter in my vocabulary) is
> useful, to me that sounds the opposite of your previous claims, but
> again: glad we agree on this too now.

I disagree with your translation.  Maybe this is the source of 
misunderstand.

To me, a "BK clone, read only for now" is vastly different from a "BK 
exporter".  The "for now" clearly implies that it will eventually 
attempt to be a full SCM.

Why do we need Yet Another Open Source SCM?
Why does Pavel not work on an existing open source SCM, to enable it to 
read/write BitKeeper files?

These are the key questions which bother me.

Why do they bother me?

The open source world does not need yet another project that is "not 
quite as good as BitKeeper."  The open source world needs something that 
  can do all that BitKeeper does, and more :)  A BK clone would be in a 
perpetual state of "not quite as good as BitKeeper".

	Jeff



