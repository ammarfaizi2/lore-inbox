Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWHTWv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWHTWv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWHTWv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:51:27 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:24214 "EHLO
	BAYC1-PASMTP04.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751765AbWHTWv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:51:26 -0400
Message-ID: <BAYC1-PASMTP04048965AE8E3CB2A134C1AE400@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Sun, 20 Aug 2006 18:51:23 -0400
From: Sean <seanlkml@sympatico.ca>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
       Josh Boyer <jwboyer@gmail.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-Id: <20060820185123.e84fafaf.seanlkml@sympatico.ca>
In-Reply-To: <20060820223046.GB10011@opteron.random>
References: <20060803204921.GA10935@kroah.com>
	<625fc13d0608031943m7fb60d1dwb11092fb413f7fc3@mail.gmail.com>
	<20060804230017.GO25692@stusta.de>
	<20060806004634.GB6455@opteron.random>
	<20060806045234.GA28849@kroah.com>
	<20060820223046.GB10011@opteron.random>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.1; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Aug 2006 22:51:25.0995 (UTC) FILETIME=[2A9BE7B0:01C6C4AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 00:30:46 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> I think it would be great to have the users choosing their preferred
> maintainer to end the era of maintainers being decided by other
> maintainers like you actually did. A simple website on kernel.org can
> achieve it, where users can registers for voting and the maintainers
> willing to maintain 2.6-stable can registers themself too. That's at
> least less random than the current status if what you said above is
> true and if 2.6.16-stable is meant to reach any critical mass.

There's no need for a vote.  Users already vote for a maintainer when
they decide to use a paticular kernel tree.

No user is forced to follow a particular maintainer.  And anyone can step
up and declare that they are also offering a maintained tree.

And this situation is already self correcting; if no users follow, it's
unlikely that a maintainer will continue doing the required work.  And
if a maintainer doesn't do a satisfactory job, it's very unlikely many
people will choose to use that tree.

Sean
