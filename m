Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753380AbWKCRIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbWKCRIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbWKCRIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:08:10 -0500
Received: from web51511.mail.yahoo.com ([206.190.39.157]:1963 "HELO
	web51511.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1753373AbWKCRII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:08:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oMmrba/N+Qc8kS828vvKJA61qf6HvFLly82quLSUizxvT3GMCsfcWEJ+Zbv8jAkRGtbAYr+YQuRBj9enGSxu9YHLvSNZuq4uX2AuiPVS177/KwdImmNsCHDLKnBZ+3PQ4VjowHAaJvtwfXUYtnWvB8PK3oypT00VYlp9uEFbvtk=  ;
Message-ID: <20061103170806.60233.qmail@web51511.mail.yahoo.com>
Date: Fri, 3 Nov 2006 09:08:06 -0800 (PST)
From: Benjamin Reed <br33d@yahoo.com>
Subject: Re: [airo.c bug] Couldn't allocate RX FID / Max tries exceeded when issueing command
To: Ivan Matveich <ivan.matveich@gmail.com>, Dan Williams <dcbw@redhat.com>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net, jt@hpl.hp.com, fabrice@bellet.info
In-Reply-To: <b5def3a40611021321h22ec79c3x51a54ec7d5b07b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might find this thread useful if it is just a case
of messed up firmware:
http://sourceforge.net/mailarchive/message.php?msg_id=2970511

The gist of it is that sometimes DOS utilities work
when all else fails.

ben

--- Ivan Matveich <ivan.matveich@gmail.com> wrote:

> On 11/2/06, Dan Williams <dcbw@redhat.com> wrote:
> > Do you know which kernel version that patch first
> appeared in?
> 
> It was committed on 1 Dec 2005, and 2.6.15 was
> released on 3 Jan 2006.
> 
> > That would be a great idea, let us know what the
> results are, especially
> > if you cna figure out which firmware version you
> have, or if the card
> > itself is really just dead.
> 
> No luck with freebsd: error resetting card.
> 
> I'll try my luck with Cisco's Windows
> utility---probably
> tomorrow---but I'd now wager that my card has simply
> croaked. (I've
> even taken it out and re-seated it in its slot, just
> in case that
> helped.) In any case, thanks for the help.
> 

