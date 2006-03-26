Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWCZQL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWCZQL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWCZQL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:11:28 -0500
Received: from main.gmane.org ([80.91.229.2]:62931 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751382AbWCZQL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:11:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: [2.6 PATCH 0/2]: Cleanup/Update FTDI_SIO
Date: Mon, 27 Mar 2006 01:11:06 +0900
Message-ID: <4426BD1A.7070204@thinrope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Folkert van Heusden <folkert@vanheusden.com>
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060324)
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Stirred by the patch from Folkert van Heusden [1], I had a look at the
code and thought it might see a bit of cleanup before adding the patch
from [1]...

So here is a series of two incremental patches:

[2.6 PATCH 1/2]: ftdi_sio.h whitespace cleanup
[2.6 PATCH 2/2]: add support for Papouch TMU (USB thermometer)

they'll be posted as a reply to this one.

I couldn't figure who the maintainer is, so not CC-ing anybody.

[1]	http://article.gmane.org/gmane.linux.kernel/392970

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

