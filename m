Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbTJISfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJISfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:35:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34576 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262387AbTJISfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:35:12 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 9 Oct 2003 18:25:30 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm496q$5c4$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0310071931570.19619@dlang.diginsite.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAG15dxRiudEualTNpHNYqMgEAAAAA@casabyte.com>
X-Trace: gatekeeper.tmr.com 1065723930 5508 192.168.12.62 (9 Oct 2003 18:25:30 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAG15dxRiudEualTNpHNYqMgEAAAAA@casabyte.com>,
Robert White <rwhite@casabyte.com> wrote:
| Actually, the point I am trying to _make_ is that Linux allows you to share
| or not share each item (already) but making a coherent "thread" implies a
| unity of interface over the entities.  We already have VM and Signals in
| that unity, but not file descriptors.  I think that's bad.  Since the old
| way lets me have this 2/3-of-a-thread already.  When I ask for a thread I
| should get a thread, not just a composite of otherwise identical shareable
| options.

I think you have wrapped yourself in nomenclature, and by using your own
definitions of terms in strictly traditional meanings you have  created
problems which aren't really there.

If you don't like it don't use it. If you insist on your own definition
of "thread" then your paragraph above may have meaning, but since your
definition doesn't seem to match the way Linux is going to work, I'm not
sure it's meaningful in any relevant context.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
