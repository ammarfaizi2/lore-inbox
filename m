Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSJaW4w>; Thu, 31 Oct 2002 17:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265476AbSJaW4v>; Thu, 31 Oct 2002 17:56:51 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:234 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S265475AbSJaW4t>; Thu, 31 Oct 2002 17:56:49 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
To: Werner Almesberger <wa@almesberger.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net,
       lkcd-devel-admin@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFAA5C1DF6.DA161B71-ON80256C63.007D0F0E@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 31 Oct 2002 22:47:41 +0000
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 31/10/2002 23:02:29
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not so convinced about this. I like the Mission Critical
> approach:

and so do many people. In fact netdump, mcode and lkcd are all
complementary parts of the same need. That's why we are working with
mcrit's blessing to merge mcore into lkcd. That's a big piece of work,
which we hope to make progress with during 2003 - Suparna's the expert :-)

Richard

