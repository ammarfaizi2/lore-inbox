Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUJYG3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUJYG3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUJYG3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:29:36 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:5392 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261614AbUJYG1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:27:05 -0400
Date: Mon, 25 Oct 2004 15:27:49 +0900 (JST)
Message-Id: <20041025.152749.00307602.yoshfuji@linux-ipv6.org>
To: jgarzik@pobox.com
Cc: nakasima@kumin.ne.jp, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: linux-2.6.9 eepro100 warning
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <417C9A4E.3030909@pobox.com>
References: <200410232313.AA00003@prism.kumin.ne.jp>
	<417C9A4E.3030909@pobox.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <417C9A4E.3030909@pobox.com> (at Mon, 25 Oct 2004 02:16:46 -0400), Jeff Garzik <jgarzik@pobox.com> says:

> Note that eepro100 driver will be deleted soon.

I'm afraid that e100 does not work well on some systems (e.g. my ThinkPad
T30 on 2.4.x) while eepro100 does.
(I also know there're systems which does not work well
with eepro100 but e100.)

Has all of such kind of issues been solved?

--yoshfuji
