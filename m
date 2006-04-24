Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWDXIXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWDXIXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWDXIXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:23:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:53934 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751132AbWDXIXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:23:42 -0400
Date: Mon, 24 Apr 2006 10:24:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424082424.GH440@marowsky-bree.de>
References: <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu> <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu> <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-23T05:45:34, Valdis.Kletnieks@vt.edu wrote:

> > AppArmor are not likely to put careful thought into the policies that
> > they use?
> They're not likely to put careful thought into it, *AND* that saying things
> like "AppArmor is so *simple* to configure" only makes things worse - this
> encourages unqualified people to create broken policy configurations.

That is about the dumbest argument I've heard so far, sorry. With the
same argument, these people shouldn't be allowed to admin any computer
system and be given a broom to wipe the floor, and let the experts take
care of the world for them.

Now that's a perfectly reasonable line of thought, and I've most
certainly had it when it comes to HA and clusters myself, but in no
means is it a good reasoning against the _technology_. If it is simpler
to use, it will be simpler to use even for smart people, who can then
put more care into their security profiles instead of worrying about the
complexity.



-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

