Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbSKOXSo>; Fri, 15 Nov 2002 18:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSKOXSo>; Fri, 15 Nov 2002 18:18:44 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:5766 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S266936AbSKOXSn>; Fri, 15 Nov 2002 18:18:43 -0500
Subject: Re: [lkcd-general] Re: [lkcd-devel] Re: What's left over.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andy Pfiffer <andyp@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Mike Galbraith <efault@gmx.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net, mjbligh@us.ibm.com,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, suparna@linux.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       "Matt D. Robinson" <yakker@aparity.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFCD0F9521.AC085965-ON80256C72.00805798@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Fri, 15 Nov 2002 23:25:10 +0000
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 15/11/2002 23:24:53
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd rather have a set of clearly defined notifiers so that I don't have
> to know about priority, just when I want to act
You mean an additional notifier solely for kexec's use that would be called
after the existing reboot notifier?


Richard

