Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWBNSqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWBNSqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWBNSqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:46:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:33687 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030460AbWBNSp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:45:59 -0500
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
	process id namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
In-Reply-To: <m1wtfytri1.fsf@ebiederm.dsl.xmission.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	 <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	 <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	 <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	 <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
	 <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru>
	 <m1wtfytri1.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 10:45:31 -0800
Message-Id: <1139942731.14254.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 22:54 -0700, Eric W. Biederman wrote:
> That is a significant issue, that needs to be fixed before I submit
> this piece of code for inclusion into the kernel.

Is there a chance you could re-post your current set, or throw them out
on kernel.org?  The thread is a week old now, and I would imagine
there's been a lot of churn. :)

-- Dave

