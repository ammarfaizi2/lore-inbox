Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWBFOgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWBFOgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWBFOgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:36:50 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:21908 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751096AbWBFOgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:36:48 -0500
Date: Mon, 6 Feb 2006 08:36:42 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [RFC][PATCH 0/5] Task references..
Message-ID: <20060206143642.GA11887@sergelap.austin.ibm.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1vevsucvy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vevsucvy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
> At the moment I am going to say thanks for the comments.
> 
> So far no one has said hey this is what I have been looking for
> and pid wrap around in the kernel is a very bad thing, thanks
> for solving my problem.
> 
> Currently this feels like overkill so I am going to shelve this
> approach for now.

Ok, then let me jump in belatedly and say I think this is a good
thing, and it will solve a problem we all (involved in this thread)
will face shortly.

And kudos for (a) a very nice, clean patchset, and (b) solving the
fowner/signal problem!

I think this would be a very good thing to go in.

thanks,
-serge
