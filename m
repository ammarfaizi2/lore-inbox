Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265425AbSJaW1k>; Thu, 31 Oct 2002 17:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbSJaW1k>; Thu, 31 Oct 2002 17:27:40 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:29156 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S265425AbSJaW1h>; Thu, 31 Oct 2002 17:27:37 -0500
Subject: Re: [lkcd-general] Re: What's left over.
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF37FD46D1.94614CDB-ON80256C63.00789235@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 31 Oct 2002 21:58:20 +0000
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 31/10/2002 22:33:20
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, I think the stock kernel does need some form of disk dumping,
> regardless of any presence/absence of netdump.  But LKCD isn't there
yet...

But if we get into 2.5 the minimal kernel piece we need, we can continue to
enhance and expand dumping capability independently of the kernel via the
dump module.  And in this respect we have been actively working on
integrating the netdump concept with lkcd.


Richard

