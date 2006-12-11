Return-Path: <linux-kernel-owner+w=401wt.eu-S1760362AbWLKJ1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760362AbWLKJ1R (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762672AbWLKJ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:27:17 -0500
Received: from main.gmane.org ([80.91.229.2]:35875 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760362AbWLKJ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:27:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Benny Amorsen <benny+usenet@amorsen.dk>
Subject: Re: Window scaling problem?
Date: 11 Dec 2006 10:26:58 +0100
Message-ID: <m33b7mhjfh.fsf@ursa.amorsen.dk>
References: <Pine.LNX.4.61.0612101001390.9675@yvahk01.tjqt.qr> <Pine.LNX.4.64.0612101507180.23130@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: kbhn-vbrg-sr0-vl209-213-185-8-10.perspektivbredband.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "CP" == Cal Peake <cp@absolutedigital.net> writes:

CP> I saw this with kernels v2.6.16, v2.6.17, and v2.6.18. Windows XP
CP> however didn't seem to have any problems. So unless Windows
CP> doesn't have window scaling on by default (or uses a workaround)
CP> it could be a broken kernel.

XP doesn't do Window Scaling by default, but Vista will. Hopefully
that should flush out the old PIX's. Versions old enough to break
Window Scaling are old enough to be insecure anyway.


/Benny


