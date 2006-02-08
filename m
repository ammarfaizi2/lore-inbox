Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWBHEbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWBHEbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWBHEbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:31:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59285 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965197AbWBHEbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:31:07 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andi Kleen <ak@suse.de>, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, serue@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, ssouhlal@freebsd.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, mrmacman_g4@mac.com, dev@sw.ru, gkurz@fr.ibm.com,
       torvalds@osdl.org, akpm@osdl.org, greg@kroah.com, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, dev@openvz.org,
       benh@kernel.crashing.org, jgarzik@pobox.com, trond.myklebust@fys.uio.no,
       jes@sgi.com
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id
 namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<1139273294.6189.170.camel@localhost.localdomain>
	<200602071033.23316.ak@suse.de>
	<20060207201923.1a97cfd6.rdunlap@xenotime.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 21:28:04 -0700
In-Reply-To: <20060207201923.1a97cfd6.rdunlap@xenotime.net> (Randy Dunlap's
 message of "Tue, 7 Feb 2006 20:19:23 -0800")
Message-ID: <m17j86bhkb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> OK.  (Yes, I have a dream.)
>
> I'd like to see less traffic on lkml, with various things moved off
> to other mailing lists.
>
> According to http://marc.theaimsgroup.com/?l=linux-kernel,
> Jan. 2006 was a near record month and Feb. is on track to be large also.

A dream I can understand.

However discussion about core kernel infrastructure is very much on
topic.  Or nothing is on topic on the mailing list.  

Once this matures to the point where we are discussing the maintenance
of a subsystem we can consider moving off lkml. 

Eric



