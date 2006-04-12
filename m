Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWDLAhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWDLAhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWDLAhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:37:18 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:11537 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751186AbWDLAhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:37:16 -0400
To: Greg KH <gregkh@suse.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
Subject: Re: several messages
References: <20060411173323.GA29965@kroah.com>
	<Pine.LNX.4.61.0604112102170.25940@yvahk01.tjqt.qr>
	<20060411203041.GA5555@suse.de>
From: Nix <nix@esperi.org.uk>
X-Emacs: it's not slow --- it's stately.
Date: Wed, 12 Apr 2006 01:36:14 +0100
In-Reply-To: <20060411203041.GA5555@suse.de> (Greg KH's message of "11 Apr 2006 21:35:44 +0100")
Message-ID: <874q0z4old.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Apr 2006, Greg KH whispered secretively:
> The first one went out last night, as it was a real issue that affected
> people and I had already waited longer than I felt comfortable with, due
> to travel issues I had (two different talks in two different cities in
> two different days.)
> 
> The second one went out today, because it was reported today.  Should I
> have waited until tomorrow to see if something else came up?

Indeed.

On top of that, they're `only' local DoSes, so many admins (i.e. those
without untrusted local users) will probably not have installed .3 yet:
and anyone with untrusted local users probably has someone whose entire
job is handling security anyway.


There's nothing wrong with rapid-fire -stables; either the issue is (in
the judgement of the ones doing the installation) critical, in which
case it should get out as fast as possible, or it isn't, in which case
the local installing admins can put it off for a day or so themselves to
see if another release comes out immediately afterwards.

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
