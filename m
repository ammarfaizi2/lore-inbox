Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932742AbWAHS3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbWAHS3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWAHS3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:29:44 -0500
Received: from fmr15.intel.com ([192.55.52.69]:3767 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S932444AbWAHS3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:29:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 13:28:50 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUK/UNNsAUD0mMS+Kj7v2U+S08rgAUVQ5w
From: "Brown, Len" <len.brown@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <torvalds@osdl.org>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <git@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2006 18:28:52.0097 (UTC) FILETIME=[6005D710:01C61481]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>I know a lot of people react to this kind of usage with "what's the
>point of the source control system if you're just messing with patches
>in and out of the tree all the time" But as a subsystem maintainer,
>you deal with a lot of changes and it's important to get a pristine
>clean history when you push things to Linus.
>
>In fact, I do this so much that Linus's tree HEAD often equals my
>origin when he pulls.
>
>Merges really suck and I also hate it when the tree gets cluttered
>up with them, and Linus is right, ACPI is the worst offender here.
>
>Yes, we can grep the merges out of the shortlog or whatever, but that
>merging crap is still physically in the tree.
>
>Just don't do it.  Merge into a private branch for testing if you
>don't want to rebuild trees like I do, but push the clean tree to
>Linus.

Perhaps the tools should try to support what "a lot of people"
expect, rather than making "a lot of people" do extra work
because of the tools?

Call me old fashioned, but I believe that tools are supposed to
make work easier, not harder.

-Len
