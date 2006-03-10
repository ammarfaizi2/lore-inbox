Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWCJEZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWCJEZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWCJEZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:25:39 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:23055 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751070AbWCJEZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:25:38 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Dave Neuer" <mr.fred.smoothie@pobox.com>,
       "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Luke-Jr" <luke@dashjr.org>, "Anshuman Gholap" <anshu.pg@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Thu, 9 Mar 2006 20:25:22 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEBLKKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <4410EAFF.9050509@cfl.rr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 09 Mar 2006 20:21:44 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 09 Mar 2006 20:21:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The key question is does work A contain substantial parts of work B?
> In  the case of a source library that is compiled and linked into an
> executable, then you can argue that the executable image is a work
> substantially derived from the library.  In the case of linking to a
> shared object however, the binary does not actually contain any of the
> material from the library, so it is not a derived work.

	Not just substantial parts, but substantial *creative* (as opposed to
functional) parts. Furthermore, are those parts combined with the work in a
*creative* way. (Otherwise you have two works in aggregate form, not a
single derived work.)

	I would argue that linking creates aggregate works just as tar does. The
key *legal* issue is whether the combination is mechanical or creative.

> In the case of ATI's drivers at least, they distribute their own object
> files which they hold the copyright to, and are not derived from the
> linux kernel in any way, and the user must link them with the correct
> objects of kernel code to create the actual loadable module.  At best if
> you could show that the final module contains substantial code from the
> kernel you might argue that it is a derived work, but since ATI only
> distributes their own object code, there's no way you can claim they are
> infringing on your copyright.

	I think that argument would fail anyway. It would require you to argue that
making an actual loadable module from the Linux kernel source and its header
files was not the normal use of those header files. I think that argument
would fail the giggle test.

	RedHat, for example, distributes a 'kernel-devel' package whose primary
purpose is to allow you to turn module source code into module executables.
Since you have the right to normal use without agreeing to the GPL (under at
least first sale), you can *create* those binary modules without agreeing to
the GPL. Remember, there is no right under copyright to specifically
restrict the *distribution* of derivative works, it relies upon you needing
the GPL to give you the right to make the derived work in the first place.

	DS


