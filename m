Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752331AbWKBVVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbWKBVVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbWKBVVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:21:19 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:34188 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752027AbWKBVVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:21:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JAjaR2NdCsn/8GF0dxJNzW309dpV7q/ce9m26YyIJgWiwxIwhDZx2hpVDrBjaFQwScaWzMW3SLN1Rw7E1fYQpyRW+jeLxKVGOP0pGTlyRERQnAsUUb04i4bjQXiPx63TouEtTF+yvjwYh84gplTgrtFs+XymI0QzY54vlMJoX70=
Message-ID: <b5def3a40611021321h22ec79c3x51a54ec7d5b07b3@mail.gmail.com>
Date: Thu, 2 Nov 2006 16:21:16 -0500
From: "Ivan Matveich" <ivan.matveich@gmail.com>
To: "Dan Williams" <dcbw@redhat.com>
Subject: Re: [airo.c bug] Couldn't allocate RX FID / Max tries exceeded when issueing command
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net, jt@hpl.hp.com, fabrice@bellet.info
In-Reply-To: <1162494679.3347.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b5def3a40611011914v59ecd4c3xb6965591524aa11@mail.gmail.com>
	 <1162483971.2646.9.camel@localhost.localdomain>
	 <b5def3a40611021030s1b73daa1k2055e5f4373fa746@mail.gmail.com>
	 <1162494679.3347.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Dan Williams <dcbw@redhat.com> wrote:
> Do you know which kernel version that patch first appeared in?

It was committed on 1 Dec 2005, and 2.6.15 was released on 3 Jan 2006.

> That would be a great idea, let us know what the results are, especially
> if you cna figure out which firmware version you have, or if the card
> itself is really just dead.

No luck with freebsd: error resetting card.

I'll try my luck with Cisco's Windows utility---probably
tomorrow---but I'd now wager that my card has simply croaked. (I've
even taken it out and re-seated it in its slot, just in case that
helped.) In any case, thanks for the help.
