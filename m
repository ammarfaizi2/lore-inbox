Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUFXMPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUFXMPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUFXMPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:15:16 -0400
Received: from [203.178.140.15] ([203.178.140.15]:43784 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S264373AbUFXMPO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:15:14 -0400
Date: Thu, 24 Jun 2004 21:16:15 +0900 (JST)
Message-Id: <20040624.211615.386508853.yoshfuji@linux-ipv6.org>
To: l.barnaba@openssl.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 INET6 Oops when executing tracepath6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1088078069.6320.5.camel@nowhere.openssl.softmedia.lan>
References: <1088078069.6320.5.camel@nowhere.openssl.softmedia.lan>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1088078069.6320.5.camel@nowhere.openssl.softmedia.lan> (at Thu, 24 Jun 2004 13:54:30 +0200), Marcello Barnaba <l.barnaba@openssl.it> says:

> tracepath6 exited with SIGSEGV.

Already fixed in current bk tree. Thanks.

--yoshfuji
