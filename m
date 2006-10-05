Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWJEQiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWJEQiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWJEQiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:38:04 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:237 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932091AbWJEQiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:38:00 -0400
Date: Thu, 5 Oct 2006 09:28:19 -0700
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061005162819.GA6510@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org> <20061004195229.GA4459@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org> <20061004204718.GA4599@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041522190.3952@g5.osdl.org> <20061005002637.GA5145@bougret.hpl.hp.com> <5a4c581d0610050820m11779c4er7a323cfec49cd39a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0610050820m11779c4er7a323cfec49cd39a@mail.gmail.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 03:20:06PM +0000, Alessandro Suardi wrote:
> On 10/5/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> >On Wed, Oct 04, 2006 at 03:26:09PM -0700, Linus Torvalds wrote:
> >>
> >> The very fact that this turned into a discussion is a sign that the ABI
> >> breakage wasn't handled well enough. Usually, when we do something, 
> >nobody
> >> ever even notices.
> >
> >        There was the grand total of *ONE* user who was personally
> >impacted by the userspace API change (the two other, one was hit by a
> >bug, now fixed, one was hit because of kernel API change + external
> >driver). And I immediately proposed to postpone the change to a later
> >time.
> 
> And said user, being me, is currently running with upgraded userspace
> without any issues (counting upgrading userspace as a non-issue).
> 
> I originally logged my report as I do for other things that break or look
> different in new snapshots, in order to provide early feedback to the
> kernel developers - I guess it's the actual point of having snapshots
> from kernel.org...

	Precisely. We are not omniscient. Based on your feedback, I
decided to postpone WE-21.
	Your feedback was useful and appreciated. I will never blame
the messenger.

> Thanks, ciao,
> 
> --alessandro

	Ciao...

	Jean
