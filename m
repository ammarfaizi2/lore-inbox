Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVADPli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVADPli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVADPli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:41:38 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:65182 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261684AbVADPlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:41:36 -0500
Message-Id: <200501041534.j04FY9g7008583@laptop11.inf.utfsm.cl>
To: Thomas Graf <tgraf@suug.ch>
cc: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7 
In-Reply-To: Message from Thomas Graf <tgraf@suug.ch> 
   of "Tue, 04 Jan 2005 04:12:29 BST." <20050104031229.GE26856@postel.suug.ch> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 04 Jan 2005 12:34:09 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf <tgraf@suug.ch> said:
> * Theodore Ts'o <20050104002452.GA8045@thunk.org> 2005-01-03 19:24

[...]

> > I was thinking more about every week or two (ok, two releases in a day
> > like we used to do in the 2.3 days was probably too freequent :-), but
> > sure, even going to a once-a-month release cycle would be better than
> > the current 3 months between 2.6.x releases.

> It definitely satifies many of the impatients but it doesn't solve the
> stability problem. Many bugs do not show up on developer machines until
> just right after the release (as you pointed out already). rc releases
> don't work out as expected due to various reasons, i think one of them
> is that rc releases don't get announced on the newstickers, extra work
> is required to patch the kernel etc. What about doing a test release
> just before releasing the final version. I'm not talking about yet
> another 2 weeks period but rather just 2-3 days and at most 2 bk
> releases in between.

And most users will just wait the extra 2 or 3 days before timidly dipping
in. Doesn't work.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
