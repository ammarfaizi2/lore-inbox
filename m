Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279610AbRJ2XUb>; Mon, 29 Oct 2001 18:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279613AbRJ2XUO>; Mon, 29 Oct 2001 18:20:14 -0500
Received: from freeside.toyota.com ([63.87.74.7]:35844 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279610AbRJ2XTm>;
	Mon, 29 Oct 2001 18:19:42 -0500
Message-ID: <3BDDE422.938C1D95@lexus.com>
Date: Mon, 29 Oct 2001 15:20:02 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <3BDDBC90.7E16E492@lexus.com> <20011029151036.F20280@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

> On Mon, Oct 29, 2001 at 12:31:12PM -0800, J Sloan wrote:
> > Say it ain't so! maybe I'm a bit dense, but is the 2.4 kernel also going
> > to wrap around after 497 days uptime? I'd be glad if someone would
> > point out the error in my understanding.
>
> Ahh, so that's why there haven't been any reports of higher uptimes... ;)

Yes, it all makes sense now -

Say, if the uptime field were unsigned it could
reach 995 days uptime before wraparound -

Surely nobody would mind having to upgrade
their kernel after 994+ days....

Well strictly speaking an upgrade isn't
forced, but if the (perceived) uptime is down
the tubes anyway, might as well update the
kernel, or the distro level for that matter.

cu

jjs





