Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSJaUQn>; Thu, 31 Oct 2002 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJaUQn>; Thu, 31 Oct 2002 15:16:43 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:21703 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263204AbSJaUQm>; Thu, 31 Oct 2002 15:16:42 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       lkcd-devel-admin@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Matt D. Robinson" <yakker@aparity.com>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFEC1A12FD.509981CC-ONC1256C63.00746AAA@de.ibm.com>
From: "Andreas Herrmann" <AHERRMAN@de.ibm.com>
Date: Thu, 31 Oct 2002 21:22:13 +0100
X-MIMETrack: Serialize by Router on D12ML033/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 31/10/2002 21:22:14
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


      Linus Torvalds <torvalds@transmeta.com>
      Sent by: lkcd-devel-admin@lists.sourceforge.net
      10/31/02 04:46 PM

On Wed, 30 Oct 2002, Matt D. Robinson wrote:

  > People have to realize that my kernel is not for random new
  > features. The stuff I consider important are things that people
  > use on their own, or stuff that is the base for other work.

A dump mechanism within the kernel is a base for much easier
kernel debugging.
IMHO, analyzing a dump is much more effective than guessing
a kernel bug solely with help of an oops message.
Using lkcd/lcrash, I've debugged enough problems in
kernel modules that were otherwise quite hard to determine.
It is hard to understand why developers do not want the
aid of dump/dump-analysis for kernel development.


Regards,

Andreas

