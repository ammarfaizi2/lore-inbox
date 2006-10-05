Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWJECao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWJECao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 22:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWJECao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 22:30:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751327AbWJECao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 22:30:44 -0400
Date: Wed, 4 Oct 2006 19:19:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061005002637.GA5145@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.64.0610041916290.3952@g5.osdl.org>
References: <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
 <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
 <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
 <20061004195229.GA4459@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
 <20061004204718.GA4599@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041522190.3952@g5.osdl.org>
 <20061005002637.GA5145@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
> 
> 	There was the grand total of *ONE* user who was personally
> impacted by the userspace API change (the two other, one was hit by a
> bug, now fixed, one was hit because of kernel API change + external
> driver). And I immediately proposed to postpone the change to a later
> time.

Heh, ok. I'm personally not able to really judge any wireless-extensions 
stuff, so I have to go by how noisy the discussion becomes ;)

I'll leave this to you guys to sort out, I just did want to pipe up (since 
I was asked to) that as far as _I_ am concerned, user-space interfaces 
really are very important. Whether this is one of the really important 
ones or not, I leave to the people involved to figure out, but I really 
don't want to have developers dismissing the issue.

(I think some people used to, and I think we've gotten better at it. But 
maybe I'm just being overly optimistic again ;)

		Linus
