Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbULMRZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbULMRZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULMRZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:25:10 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:26500 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261290AbULMRUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:20:37 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-5.tower-45.messagelabs.com!1102958432!8387175!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Unknown Issue.
Date: Mon, 13 Dec 2004 12:20:30 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC417A@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unknown Issue.
Thread-Index: AcThNyMyyZLRMWkhR6mZ1NQoigplOgAABWew
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Patrick" <nawtyness@gmail.com>, "Eric Sandeen" <sandeen@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Linus Torvalds" <torvalds@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So your problem was only temporary?

Or?

After I began having the problem, I was trying to edit some files and
then I got the same errors as you, ie: /usr/bin/vi Input/Ouput error,
and then I tried to run or edit different programs and files and nothing
was working.  

Were you also forced to re-install, or does this only happen sometimes?

-----Original Message-----
From: Patrick [mailto:nawtyness@gmail.com] 
Sent: Monday, December 13, 2004 12:14 PM
To: Eric Sandeen
Cc: Piszcz, Justin Michael; linux-kernel@vger.kernel.org;
linux-xfs@oss.sgi.com; Andrew Morton; Kristofer T. Karas; Jeff Garzik;
Linus Torvalds
Subject: Re: Unknown Issue.

Hi, 

> Patrick, can you reproduce on a non-gentoo kernel?  That'd be the
first
> step for this audience.

I've not tried to reproduce it on a non-gentoo kernel as the original
one that i had the problem was a vanilla kernel ;) ( as i know your
fondness of gentoo's patch-o-lotic )

I've been abusing the box the entire day with FreeBSD, the same mysql
config and version of the mysqld as well as the same operations ( and
some more ... serious ones ( e.g. forkbomb, iozone, etc. ) and no
problem's.

There were no messages in the log, and nothing in kmesg. Anything else
i could try ? Also, as far as i know i was running kernel 2.6.10_rc3
and i'd reinstalled the box twice with new XFS filesystems both times.

P
