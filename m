Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbTLCUVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbTLCUVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:21:36 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64010 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265164AbTLCUV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:21:27 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: XFS for 2.4
Date: 3 Dec 2003 20:10:17 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlfv9$j9h$1@gatekeeper.tmr.com>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com> <20031202175957.GA1990@gtf.org>
X-Trace: gatekeeper.tmr.com 1070482217 19761 192.168.12.62 (3 Dec 2003 20:10:17 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031202175957.GA1990@gtf.org>,
Jeff Garzik  <jgarzik@pobox.com> wrote:

| It's _very_ wise to hold off on a patch if
| (a) the code is difficult to read, and therefore difficult to review and
|     fix (read: style)
| (b) the maintainer is not assured of patch reliability (read: "I'm not
|     sure the patch won't break things")
| 
| Both (a) and (b) are vaild concerns for long term maintenance costs.
| 
| Particularly (b).  If Marcelo is not assured of patch reliability, then
| he absolutely --should not-- merge XFS into 2.4.  That's just the way
| the system works.  And it's a good system.

Given that hundreds of people have used it for several years, I find it
hard to believe that there are hidden bugs both so subtle that they
have not been seen and so bad that they cause major problems. I find "I
don't like the coding style" far easier to believe.

As you say, that's the way the system works, guess the patch will
continue, because it's more reliable than 2.6 at the moment.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
