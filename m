Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTIYSl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTIYSl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:41:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:5609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261710AbTIYSl5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:41:57 -0400
Date: Thu, 25 Sep 2003 11:33:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: torvalds@osdl.org, ebiederm@xmission.com, andrea@kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org,
       marcelo.tosatti@cyclades.com.br, lm@bitmover.com
Subject: Re: log-buf-len dynamic
Message-Id: <20030925113327.39a01649.rddunlap@osdl.org>
In-Reply-To: <20030925182233.GA1356@wohnheim.fh-wedel.de>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
	<20030925182233.GA1356@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003 20:22:33 +0200 Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

| On Thu, 25 September 2003 10:30:58 -0700, Linus Torvalds wrote:
| > 
| > That's actually a pretty good point. I end up releasing "sparse" only as a
| > BK archive, simply because I'm too lazy to care and there aren't enough
| > people involved (and those that _are_ involved do actually end up
| > re-exporting it as non-BK, but that doesn't invalidate your point).
| 
| Actually, sparse taught me how life was before the internet.  I had to
| ask someone else to get it for me, don't want to bother him on a
| regular basis and am stuck with an old version.  Not that I've done
| anything with it worth giving back, but I do feel the pain.
| 
| On the other hand, if it matters enough, people will find solutions.
| Would be nice, if Larry coded up something central that all projects
| could benefit from, but that is not necessary.  All projects that grow
| important enough will have a solution someday.
| 
| BTW: Is there a non-bk way to get recent sparse code yet?

Snapshots are available at
  http://www.codemonkey.org.uk/projects/sparse/


--
~Randy
