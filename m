Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVLGObU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVLGObU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVLGObU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:31:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751097AbVLGObT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:31:19 -0500
Date: Wed, 7 Dec 2005 09:30:56 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Tim Bird <tim.bird@am.sony.com>
cc: David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
In-Reply-To: <4394D396.1020102@am.sony.com>
Message-ID: <Pine.LNX.4.63.0512070927260.17172@cuia.boston.redhat.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> 
 <200512051826.06703.andrew@walrond.org>  <1133817575.11280.18.camel@localhost.localdomain>
  <1133817888.9356.78.camel@laptopd505.fenrus.org>
 <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Tim Bird wrote:

> To the larger argument about supporting binary drivers,
> all Arjan manages to prove with his post is that,
> if handled in the worst possible way, support for
> binary drivers would be a disaster.  Who can disagree
> with that?

>From my point of view, supporting binary drivers IS
the worst possible thing we could do.

It is all too common that a user ends up with two
binary drivers in his kernel, and both of the binary
driver vendors tell the user "try without the other
vendor's driver, otherwise we will not support you".

In the mean time, the user and the distro are caught
in-between two finger pointing binary driver vendors,
with no possibility of fixing the problem the user has.

3rd party binary drivers are such a support nightmare
that I wouldn't wish them on anyone.  Especially not
on end users...

-- 
All Rights Reversed
