Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266911AbSKOWwz>; Fri, 15 Nov 2002 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbSKOWwz>; Fri, 15 Nov 2002 17:52:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266897AbSKOWwx>;
	Fri, 15 Nov 2002 17:52:53 -0500
Message-ID: <3DD57C42.3000107@pobox.com>
Date: Fri, 15 Nov 2002 17:59:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Khoa Huynh <khoa@us.ibm.com>
CC: "David S. Miller" <davem@redhat.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <OFD55E09AF.09FEF8A7-ON85256C72.007B18B9@pok.ibm.com>
In-Reply-To: <OFD55E09AF.09FEF8A7-ON85256C72.007B18B9@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khoa Huynh wrote:

> David Miller wrote:
>
>
> >mozilla handles it this way: the bug starts as unconfirmed. they have a
> >  volunteer group of pre screeners. Only when one of these people sets
> >  it to valid or similar then the owners of the module get mail.
> >
> >This sounds like a good idea.
>
>
> Currently in the kernel bugzilla, after a bug is filed, it is initially
> in the OPEN state -- this is similar to the Unconfirmed state mentioned
> above.  The screeners (my team and others who volunteer) can get rid of
> many invalid bugs and dups.  Only valid bugs then go to the ASSIGNED state
> with correct owners.  Of course, we do not expect to get rid 100% of all
> the invalids and dups, but at least that should reduce the work of
> the owners who should only work with bugs in the ASSIGNED state.


The bugs assigned to me are all in the 'open' state, with no obvious way 
to change them to 'assigned'.

> Also, the bug owner can close MULTIPLE bugs at the same time
> on Bugzilla.  A bug owner can query all of his bugs which will
> then be displayed in a list, click the option "Change several bugs
> at once" at the bottom of the list, select the bugs that he wants
> to close, and then hit Commit button.  It's pretty simple.  Besides
> closing the bugs, the owner can make similar changes to several bugs
> at the same time using the same mechanism.



The basic point still stands, though, that if the bug owner must close 
multiple bugs at once, they are likely clearing out garbage and that 
each individual bug is not necessarily unique or valid...

	Jeff



