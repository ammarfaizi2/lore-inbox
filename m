Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTKPDZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTKPDZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 22:25:04 -0500
Received: from web10408.mail.yahoo.com ([216.136.130.110]:10332 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262176AbTKPDZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 22:25:00 -0500
Message-ID: <20031116032459.99308.qmail@web10408.mail.yahoo.com>
Date: Sun, 16 Nov 2003 14:24:59 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.6.0-test6 with low mem box, too slow to start openoffice
To: Ed Tomlinson <edt@aei.ca>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200311151822.38460.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, thanks for your reply.

> with open office.  It makes
> massive use of yield().  What this does changes in
> 2.6 - it now works as expected

However I noticed that if I use 2.6.0-test9-mm1 or
mm2; the problem seems to be solved. With mm1, it even
starts Openoffice faster than 2.4.x (34 sec compared
with 46sec). The only problem with mm kernel is, the
vmware modules for 2.6 kernel I get from 
http://ftp.cvut.cz/vmware/  causes OOPs. I experience
considerable performance improvd with mm kernel.

Hope finnally the performace tweak in mm kernel will
get merged and the author of vmware modules for 2.6
fixed the OOP.

> and this hurts some versions of open office.
> 
> Ed 

Cheers,



=====
S.KIEU

http://personals.yahoo.com.au - Yahoo! Personals
New people, new possibilities. FREE for a limited time.
