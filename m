Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbSKPAAv>; Fri, 15 Nov 2002 19:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266943AbSKPAAv>; Fri, 15 Nov 2002 19:00:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57862 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266941AbSKPAAu>;
	Fri, 15 Nov 2002 19:00:50 -0500
Message-ID: <3DD58C31.5090900@pobox.com>
Date: Fri, 15 Nov 2002 19:07:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Khoa Huynh <khoa@us.ibm.com>, "David S. Miller" <davem@redhat.com>,
       ak@suse.de, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <3DD57C42.3000107@pobox.com> <470718948.1037373699@[10.10.2.3]>
In-Reply-To: <3DD57C42.3000107@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> >The bugs assigned to me are all in the 'open' state, with no
> >obvious way to change them to 'assigned'.
>
>
> There's a radio button just below the additional comments box,
> "Accept bug (change status to ASSIGNED)". Then hit Commit.


That would be the obvious way, but that option is not presented to me :)
Look at http://gtf.org/garzik/misc/Screenshot.png  ;-)

Tangent:  Red Hat's bugzilla has a 'NEEDINFO' status which is quite 
useful too.


> >>Also, the bug owner can close MULTIPLE bugs at the same time
> >>on Bugzilla.  A bug owner can query all of his bugs which will
> >>then be displayed in a list, click the option "Change several bugs
> >>at once" at the bottom of the list, select the bugs that he wants
> >>to close, and then hit Commit button.  It's pretty simple.  Besides
> >>closing the bugs, the owner can make similar changes to several bugs
> >>at the same time using the same mechanism.
> >
> >The basic point still stands, though, that if the bug owner must 
> close multiple bugs at once, they are likely clearing out garbage and 
> that each individual bug is not necessarily unique or valid...
>
>
> If it gets onerous in terms of numbers of bugs filed, we can get people
> to prefilter them. I think that things will calm down in a week or so,
> but if you want, I can find someone to do that for network drivers.


I'm willing to wait and see how things settle out in a few weeks.  I 
doubt it will be a huge problem for me personally, but as we see on the 
mailing lists already, there are plenty of bogus net stack bug reports 
[I know, I posted one just today and got corrected by Alexey].  I forsee 
David having a much bigger problem with potential bugzilla-related grunt 
work...

If you think back to what I first proposed, the original idea was to 
minimize the grunt work on kernel developers so we could focus on 
solving the tough problems :)  As I said back then, that definitely 
implies some useful help from staff and community to keep the bug 
database clean.  I think Andi Kleen mentioned that Mozilla project has 
bugs begin life as pre-screened... I think that's a pretty good model. 
Since you pointed out that Bugzilla supports that model from a technical 
standpoint, all we need are the pre-screeners to help us out... :)

	Jeff



