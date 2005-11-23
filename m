Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVKWG1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVKWG1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVKWG1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:27:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7046 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030328AbVKWG1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:27:02 -0500
Date: Wed, 23 Nov 2005 01:26:45 -0500
From: Dave Jones <davej@redhat.com>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051123062645.GB1481@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Harald Dunkel <harald.dunkel@t-online.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20051121225303.GA19212@kroah.com> <20051122175017.GA10783@kroah.com> <43839C2E.3030904@t-online.de> <1132702803.20233.95.camel@localhost.localdomain> <438406EA.1050705@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438406EA.1050705@t-online.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 07:06:34AM +0100, Harald Dunkel wrote:
 
 > Talking about the other side: Some months ago NVidia dropped
 > support for some old (3 yrs, AFAIR) graphics cards in their
 > proprietary driver. They could have considered to release the
 > sources for this "old stuff" instead.

The age of the code/hardware is irrelevant. The big problem
these folks have is the fear that they're infringing on the
other guys patents.

They have relatively little to gain from such a goodwill gesture,
and a hell of a lot to lose. iirc, 3dfx disappeared overnight due to
legal battles that went..

"You lose, pay us lots of money, or let us buy you out and own your IP."

Even non-competitive vendors like Matrox have now gone binary-only,
likely due to the same concerns (It for sure isn't to hide some
super secret performance edge).

		Dave

