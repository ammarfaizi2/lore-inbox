Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274859AbTHALCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 07:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275212AbTHALCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 07:02:03 -0400
Received: from 213-0-202-111.dialup.nuria.telefonica-data.net ([213.0.202.111]:34184
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S274859AbTHALAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 07:00:51 -0400
Date: Fri, 1 Aug 2003 13:00:49 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm2
Message-ID: <20030801110049.GB5762@localhost>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20030730223810.613755b4.akpm@osdl.org> <1059648996.1263.1.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1059648996.1263.1.camel@debian>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 31 July 2003, at 12:57:23 +0200,
Ramón Rey Vicente???? wrote:

> The best desktop experience for me since I run 2.5/2.6 kernels. No more
> sound skips and a very good response of all applications into  the
> X-Windows.
> 
I have the same opinion with respect to 2.6.0-test2-mm2 here, but with a
box much more powrful than yours (fact that did not prevent jerky
behaviour in past kernel releases though).

Under my "common" workload (X, Mozilla in pages full of crap^Wflash,
xmms, several monitors, spamassassin analyzing no less than 10
simultaneous mails, and "make -j25 bzImage" to add some more work to the
mix) mouse movement was smooth, and MP3 didn't skip. So i nthis aspect,
2.6.0-test2-mm2 is better than 2.6.0-test2-G7 (2.6.0-test2 with Ingo's
sched-2.6.0-test1-G7).

But there is one thing 2.6.0-test2-mm2 "does" worse than 2.6.0-test2-G7,
and that is prevent windows in X to freeze under heavy window movement
(with "show contents of windows while moving" ON, of course). Under
2.6.0-test2-G7 I was unable to make windows freeze, but with
2.6.0-test2-mm2 I can after several seconds, and the moving window (and
the rest of them) get frozen for a while (couple of seconds).

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test2-mm2)
