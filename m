Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSKOVni>; Fri, 15 Nov 2002 16:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266767AbSKOVni>; Fri, 15 Nov 2002 16:43:38 -0500
Received: from ns.suse.de ([213.95.15.193]:44042 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266765AbSKOVnh>;
	Fri, 15 Nov 2002 16:43:37 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <396026666.1037298946@[10.10.2.3].suse.lists.linux.kernel> <1037395835.22209.3.camel@rth.ninka.net.suse.lists.linux.kernel> <336460000.1037398316@flay.suse.lists.linux.kernel> <20021115.133004.65979948.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2002 22:50:33 +0100
In-Reply-To: "David S. Miller"'s message of "15 Nov 2002 22:34:40 +0100"
Message-ID: <p73of8qv6xi.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> I'm more concerned about the inevitable explosion of duplicates
> and "fixed already"'s.

mozilla handles it this way: the bug starts as unconfirmed. they have a 
volunteer group of pre screeners. Only when one of these people sets
it to valid or similar then the owners of the module get mail.

I guess that could work for the linux kernel bugzilla too. Never hazzle
a developer, until someone confirmed the bug in some way (this does not
mean that he needs to reproduce it, just weed out obvious duplicates
and bogus postings) 

-Andi
