Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWCUSNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWCUSNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWCUSNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:13:04 -0500
Received: from pat.uio.no ([129.240.130.16]:24228 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964956AbWCUSNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:13:00 -0500
Subject: Re: [GIT] NFS client update for 2.6.16
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
In-Reply-To: <44203D00.4030507@garzik.org>
References: <1142961077.7987.14.camel@lade.trondhjem.org>
	 <44203D00.4030507@garzik.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:12:47 -0500
Message-Id: <1142964767.7987.65.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.713, required 12,
	autolearn=disabled, AWL 1.29, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 12:50 -0500, Jeff Garzik wrote:
> Trond Myklebust wrote:
> > Hi Linus,
> > 
> > Please pull from the repository at
> > 
> >    git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git
> > 
> > This will update the following files through the appended changesets.
> 
> It would IMO be nice if you would pipe the changelog through 'git 
> shortlog', to better summarize the submission.  And if the cumulative 
> patch isn't over 100k or so, include that in the email for any last 
> minute review.

The cumulative patch in this case is 291k (smaller than usual, but not
insignificant).
In any case, the individual patches and the cumulative patch are
available, as always, from linux-nfs.org. Please see

  http://client.linux-nfs.org/Linux-2.6.x/2.6.16/

> I've attached the simple script I use to generate pull emails for 
> Andrew/Linus...

Thanks.

Cheers,
  Trond

