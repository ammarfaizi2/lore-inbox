Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUF2NUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUF2NUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 09:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUF2NUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 09:20:24 -0400
Received: from fmx3.freemail.hu ([195.228.242.223]:5901 "HELO fmx3.freemail.hu")
	by vger.kernel.org with SMTP id S264482AbUF2NUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 09:20:23 -0400
Date: Tue, 29 Jun 2004 15:20:06 +0200 (CEST)
From: Debi Janos <debi.janos@freemail.hu>
Subject: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
To: linux-kernel@vger.kernel.org
Message-ID: <freemail.20040529152006.85505@fm4.freemail.hu>
X-Originating-IP: [195.56.253.245]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am found an interesting (bug?) feature in kernels between
2.6.7-mm1 and 2.6.7-mm4

Some web pages eg. 

http://www.hup.hu/
http://portal.fsn.hu/
http://wiki.hup.hu/

is unreachable with these kernels. If i try kernel versions
<= 2.6.7 everything is O.K. above-mentioned all web pages works.

I try this web pages with some different operating systems
like Windows, OpenBSD, FreeBSD, WinCe... and seems working
fine for me.

Any idea?

Thanks.
