Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTIEQRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTIEQRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:17:36 -0400
Received: from zeus.kernel.org ([204.152.189.113]:2548 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265603AbTIEQR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:17:26 -0400
Date: Fri, 5 Sep 2003 09:08:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Brad Parker" <parker@citynetwireless.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: programming with /proc functions
Message-Id: <20030905090825.63bde24b.rddunlap@osdl.org>
In-Reply-To: <005401c37359$e6c30550$20f6d618@bp>
References: <005401c37359$e6c30550$20f6d618@bp>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 22:00:44 -0500 "Brad Parker" <parker@citynetwireless.net> wrote:

| How can I find out what I need to change for a module (which creates a /proc
| entry) I wrote for 2.2 to work under 2.4, meaning, things like
| proc_register[_dynamic], proc_unregister etc. are gone now, how do I go
| about figuring out what all needs to be changed?

I don't recall a 2.2-to-2.4 porting guide.  Anyone else?

There is a 2.4 /proc fs guide at
http://kernelnewbies.org/documents/kdoc/procfs-guide/lkprocfsguide.html
that may help you.

--
~Randy
