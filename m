Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTIWS3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbTIWS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:29:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47365 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263338AbTIWS3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:29:31 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80,
	in 2.6?
Date: 23 Sep 2003 18:20:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bkq2sv$esv$1@gatekeeper.tmr.com>
References: <m165jkk5vn.fsf@ebiederm.dsl.xmission.com> <1064275788.9832.1.camel@dhcp23.swansea.linux.org.uk>
X-Trace: gatekeeper.tmr.com 1064341215 15263 192.168.12.62 (23 Sep 2003 18:20:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1064275788.9832.1.camel@dhcp23.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
| On Llu, 2003-09-22 at 19:58, Eric W. Biederman wrote:
| > Alan, can you describe a little more what the original delay is needed
| > for?  I don't see it documented in my 8254 data sheet.  The better I
| > can understand the problem the better I can write the comments on this
| > magic bit of code as I fix it.
| 
| If I remember rightly its because it is a 2Mhz part on an 8Mhz bus.

And I thought I was a hotshot overclocker ;-)
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
