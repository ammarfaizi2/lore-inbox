Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVADV70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVADV70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVADV4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:56:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:34829 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262372AbVADVwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:52:12 -0500
Date: Tue, 4 Jan 2005 22:43:24 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Thomas Graf <tgraf@suug.ch>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104214324.GG22075@alpha.home.local>
References: <20050104031229.GE26856@postel.suug.ch> <200501041534.j04FY9g7008583@laptop11.inf.utfsm.cl> <20050104211910.GB7280@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104211910.GB7280@thunk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:19:10PM -0500, Theodore Ts'o wrote:
> The problem with the -rc releases is that we try to predict in advance
> which releases in advance will be stable, and we don't seem to be able
> to do a good job of that.

I really like this description, it's the most accurate description I ever
read of an -rc release. I wish you could convince Linus with it. 

The problem with -rc is that if we try to predict, it implies that we don't
expect to count much on user reports. Then why do an -rc at all if we don't
expect enough testings ?

> If we do a release every week, my guess is
> that at least 1 in 3 releases will turn out to be stable enough for
> most purposes.  But we won't know until after 2 or 3 days which
> releases will be the good ones.

That's always been my point, and one of the reasons why *some* of Alan's
kernels work well.

> In practice, that's all the -rc releases are these days anyway (there
> are times when a 2.6.x-rcy release is more stable than 2.6.z).  The
> problem is that since the -rc releases are called what they are
> called, they don't get enough testing.

Perfectly true. I would add that with -rc releases, people only upgrade when
we tell them that they can, while with more frequent releases, they upgrade
when they *need* to, and can try several versions if the first one they pick
does not work.

Regards,
Willy

