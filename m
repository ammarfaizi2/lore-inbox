Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUGLUOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUGLUOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGLUOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:14:21 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40424 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262328AbUGLUOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:14:19 -0400
X-Sasl-enc: Uv3KC/7aniSFEFU5R0pcGA 1089663264
Message-ID: <00b001c4684c$d060bb20$9aafc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Chris Mason" <mason@suse.com>, <linux-kernel@vger.kernel.org>
References: <00f601c46539$0bdf47a0$e6afc742@ROBMHP> <1089377936.3956.148.camel@watt.suse.com> <009e01c46849$f2e85430$9aafc742@ROBMHP> <20040712201154.GI21066@holomorphy.com>
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
Date: Mon, 12 Jul 2004 13:14:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nice, deep stack there; however, this appears to only be one process. It
> may be helpful to see the others.

I've put the dumps here. I did sysreq-t twice, thus the 2 dumps. If you diff 
them, you'll see they're very very similar.

http://robm.fastmail.fm/kernel/t2/

Rob

