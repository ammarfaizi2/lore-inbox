Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTG1KWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 06:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTG1KWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 06:22:37 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:44818 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S263752AbTG1KWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 06:22:36 -0400
Message-Id: <200307281028.h6SASBj12316@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [ANNC] linld 0.96 is available
Date: Mon, 28 Jul 2003 13:37:35 +0300
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linld 0.96 is available at

http://sort.imtp.ilyichevsk.odessa.ua/linux/linld/

HISTORY
=======
Acknowledgements
----------------
Lots of code was borrowed from loadlin source
(author of loadlin is Hans Lermen <lermen@elserv.ffm.fgan.de>).
Some code from linux kernel (setup.S) was used too. 
Thank you guys!
 
Todo
----
?

Changelog 
---------
0.91    Added support for cl=@filename
0.92    VCPI voodoo magic: booting under EMM386 and foes :-)
0.93    Cleanup. cl=@filename: cr/lf will be converted to two spaces 
0.94    Ugly workaround for DOS int 15 fn 88 breakage
0.95    Bug squashed: vga=NNN did not like dec numbers, oct/hex only
	Some VCPI comments added
0.96    Do not lowercase entire command line.
--
vda
