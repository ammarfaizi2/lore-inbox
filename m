Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUJRMJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUJRMJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 08:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUJRMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 08:09:40 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:49842 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S266362AbUJRMJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 08:09:12 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: 2.6.9-rc3 and rc4 (and final): parallel printer has gone
Date: Mon, 18 Oct 2004 12:09:11 +0000 (UTC)
Organization: Wurtelization
Message-ID: <cl0bp7$ku9$1@news.cistron.nl>
References: <200410171218.23232.T.Maguin@web.de> <200410171924.25845.T.Maguin@web.de>
X-Trace: ncc1701.cistron.net 1098101351 21449 195.64.88.114 (18 Oct 2004 12:09:11 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Maguin  <T.Maguin@web.de> wrote:
>
>With kernel 2.6.9-rc4-mm1 the parallel printer is visible again.

Ah, good to know.
My parallel port had also disappeared, also with 2.6.9-final.
I get the message:
	lp: driver loaded but no devices found

In /proc/ioports there is a line:
	0378-037a : winbond parport


Paul Slootman

