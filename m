Return-Path: <linux-kernel-owner+w=401wt.eu-S932480AbWLMOQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWLMOQM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWLMOQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:16:12 -0500
Received: from [212.33.161.160] ([212.33.161.160]:33016 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932480AbWLMOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:16:11 -0500
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 09:16:09 EST
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Postgrey experiment at VGER
Date: Wed, 13 Dec 2006 17:11:28 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612131711.28292.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2006-12-13 at 11:25 +0200, Dumitru Ciobarcianu wrote:
> > On Wed, 2006-12-13 at 01:50 +0200, Matti Aarnio wrote:
> > > I do already see spammers smart enough to retry addresses from
> > > the zombie machine, but that share is now below 10% of all emails.
> > > My prediction for next 200 days is that most spammers get the clue,
> > > but it gives us perhaps 3 months of less leaked junk.

Great!

> > IMHO this is only an step in an "arms race".
> > What you will do in three months, remove this check because it will
> > prove useless since the spammers will also retry ? If yes, why install
> > it in the first place ?
>
> Why ever do anything? You're going to die eventually anyway...

Right!  The problem here is that it may do more harm than good.

May I suggest a smarter way to filter these spammers, by just whitelisting 
email addresses of valid posters, after sending a confirmation for the first 
post.  Now if these spammers get smart, and start using personal email 
addresses, I would certainly expect some real action by abused email address 
owners.


Thanks!

--
Al

