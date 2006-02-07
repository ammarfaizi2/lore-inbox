Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWBGAsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWBGAsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWBGAsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:48:35 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39079 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964909AbWBGAse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:48:34 -0500
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id
	namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
In-Reply-To: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 16:48:13 -0800
Message-Id: <1139273294.6189.170.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 12:19 -0700, Eric W. Biederman wrote:
> p.s.  My apologies at the size of the CC list.  It is very hard to tell who
> the interested parties are, and since there is no one list we all subscribe
> to other than linux-kernel how to reach everyone in a timely manner.  I am
> copying everyone who has chimed in on a previous thread on the subject.  If
> you don't want to be copied in the future tell and I will take your name off
> of my list.

Is it worth creating a vger or OSDL mailing list for these discussions?
There was some concern the cc list is getting too large. :)

If yes, would "linux-containers" be an appropriate name?

-- Dave

