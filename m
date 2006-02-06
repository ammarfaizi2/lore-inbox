Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWBFILW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWBFILW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWBFILW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:11:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44005 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750752AbWBFILV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:11:21 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [RFC][PATCH 0/5] Task references..
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 01:09:37 -0700
In-Reply-To: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Sun, 29 Jan 2006 00:19:56 -0700")
Message-ID: <m1vevsucvy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the moment I am going to say thanks for the comments.

So far no one has said hey this is what I have been looking for
and pid wrap around in the kernel is a very bad thing, thanks
for solving my problem.

Currently this feels like overkill so I am going to shelve this
approach for now.

Eric


