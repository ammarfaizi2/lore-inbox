Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbTHWTSz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 15:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263699AbTHWTSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 15:18:55 -0400
Received: from pixy-gw.netlab.is.tsukuba.ac.jp ([130.158.83.98]:14342 "HELO
	pixy.netlab.is.tsukuba.ac.jp") by vger.kernel.org with SMTP
	id S263685AbTHWTSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 15:18:52 -0400
To: vmlinuz386@yahoo.com.ar
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH][resend] 6/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/scsi/pcmcia
In-Reply-To: <20030822041522.0daf7ff6.vmlinuz386@yahoo.com.ar>
References: <20030822041522.0daf7ff6.vmlinuz386@yahoo.com.ar>
X-Mailer: Mew version 1.94.2 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20030824041845U.yokota@netlab.is.tsukuba.ac.jp>
Date: Sun, 24 Aug 2003 04:18:45 +0900
From: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Gerardo.

 Thanks for your patch. This probrem is fixed on Kernel 2.6.0-test4.
And you can get independent source code from
http://www.netlab.is.tsukuba.ac.jp/~yokota/izumi/ninja/



From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Subject: [PATCH][resend] 6/13 2.4.22-rc2 fix __FUNCTION__ warnings drivers/scsi/pcmcia
Date: Fri, 22 Aug 2003 04:15:22 -0300

> Hi people,
> this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated


---
YOKOTA Hiroshi
E-mail: yokota@netlab.is.tsukuba.ac.jp
WWW:    http://www.netlab.is.tsukuba.ac.jp/~yokota/
