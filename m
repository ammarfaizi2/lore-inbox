Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUCCWiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUCCWiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:38:01 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:29859 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261233AbUCCWhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:37:47 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: per-cpu blk_plug_list
Date: Wed, 3 Mar 2004 22:37:45 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c25mnp$m90$1@news.cistron.nl>
References: <cistron.B05667366EE6204181EABE9C1B1C0EB50211E5C8@scsmsx401.sc.intel.com> <20040303094509.GA8779@cistron.nl> <20040303015448.749a87d2.akpm@osdl.org> <20040303162424.GC19960@traveler.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1078353465 22816 62.216.29.200 (3 Mar 2004 22:37:45 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040303162424.GC19960@traveler.cistron.net>,
Miquel van Smoorenburg  <miquels@cistron.nl> wrote:
>On 2004.03.03 10:54, Andrew Morton wrote:
>> Sure.  This is all nice and simple stuff, except for the locking, which
>> needs serious work.
>
>Is this a step in the right direction ?
>
>dm-rwlock.patch

Forget this one, I sent a better one to linux-lvm@redhat.com.

Mike.

