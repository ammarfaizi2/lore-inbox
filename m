Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030988AbWKUOLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030988AbWKUOLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 09:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030989AbWKUOLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 09:11:46 -0500
Received: from [212.33.185.24] ([212.33.185.24]:36736 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030988AbWKUOLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 09:11:46 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Where did find_bus() go in 2.6.18?
Date: Tue, 21 Nov 2006 17:15:01 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211715.01963.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Nov 20, 2006 at 04:13:22PM +0200, Paul Sokolovsky wrote:
> > And suddenly - oops, in 2.6.18 we lose ability to query the highest
> > level of hierarchy, namely bus set. And on what criterion? "unused".
>
> Please go read Documenation/stable_api_nonsense.txt for why the
> in-kernel apis always change.  It's how Linux works.
>
> > Suddenly, concrete building of LDM appears to be shaking. And reasonable
> > question here is: is this a trend?

Good question.

> > > Also, any reason why your drivers aren't in the mainline kernel yet? 
> >
> > One reason is of course because it's not that easy to get something
> > into mainline. ;-)
>
> Why do you feel this way?  Is it a proceedural thing?  A technical
> thing?  A time thing?
>
> We want to make it as easy as possible to get code into the tree, please
> submit it and be persistant to get it there.

Persistent as in: get down on your knees and say "please, please, pretty 
please"?

AFAICT, code is being ignored/rejected for the mere reason that it's not 
considered useful; but who's to say what is useful and what's not?

There should probably be some guideline to indicate what kind of code is 
acceptable and what's not.  You know, something like a constitution.  
Otherwise, we'll probably have a situtation like the jungle, where the weak 
are silently being killed off.

Is that the kind of evolution you are aiming for?

BTW, no troll, really.


Thanks!

--
Al

