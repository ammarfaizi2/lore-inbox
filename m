Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbSKOW3W>; Fri, 15 Nov 2002 17:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbSKOW26>; Fri, 15 Nov 2002 17:28:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11676 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266859AbSKOW2H>;
	Fri, 15 Nov 2002 17:28:07 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, mbligh@aracnet.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD55E09AF.09FEF8A7-ON85256C72.007B18B9@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Fri, 15 Nov 2002 16:34:45 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/15/2002 05:34:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Miller wrote:

> mozilla handles it this way: the bug starts as unconfirmed. they have a
>   volunteer group of pre screeners. Only when one of these people sets
>   it to valid or similar then the owners of the module get mail.
>
>This sounds like a good idea.

Currently in the kernel bugzilla, after a bug is filed, it is initially
in the OPEN state -- this is similar to the Unconfirmed state mentioned
above.  The screeners (my team and others who volunteer) can get rid of
many invalid bugs and dups.  Only valid bugs then go to the ASSIGNED state
with correct owners.  Of course, we do not expect to get rid 100% of all
the invalids and dups, but at least that should reduce the work of
the owners who should only work with bugs in the ASSIGNED state.

Also, the bug owner can close MULTIPLE bugs at the same time
on Bugzilla.  A bug owner can query all of his bugs which will
then be displayed in a list, click the option "Change several bugs
at once" at the bottom of the list, select the bugs that he wants
to close, and then hit Commit button.  It's pretty simple.  Besides
closing the bugs, the owner can make similar changes to several bugs
at the same time using the same mechanism.

Regards,
Khoa
_________________________________________
Khoa Huynh, Ph.D.
IBM Linux Technology Center
(512) 838-4903; T/L 678-4903; khoa@us.ibm.com


