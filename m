Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTGHRuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267525AbTGHRuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:50:15 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:62990 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265090AbTGHRuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:50:12 -0400
Date: Wed, 09 Jul 2003 03:06:16 +0900 (JST)
Message-Id: <20030709.030616.94815084.yoshfuji@linux-ipv6.org>
To: arvidjaar@mail.ru
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: 2.5.74 - BUG in kfree during sys_close from netstat
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200307082155.49404.arvidjaar@mail.ru>
References: <200307082155.49404.arvidjaar@mail.ru>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200307082155.49404.arvidjaar@mail.ru> (at Tue, 8 Jul 2003 21:59:50 +0400), Andrey Borzenkov <arvidjaar@mail.ru> says:

> Mandrake 9.1, kernel 2.5.74. Started kmail, started kppp, connected, attempted 
> to send or receive - nothing happened. Run netstat -an - and got

already fixed in Linus's tree.

--yoshfuji
