Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVDQISs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVDQISs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 04:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVDQISs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 04:18:48 -0400
Received: from pD9F86D3F.dip0.t-ipconnect.de ([217.248.109.63]:52355 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261283AbVDQISq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 04:18:46 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: linux.kernel
Subject: More performance for the TCP stack by using additional hardware chip
 on NIC
Date: Sun, 17 Apr 2005 10:17:49 +0200
Organization: privat
Message-ID: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@arcor.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050405
X-Accept-Language: de, en-us, en
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Alacritech developed a new chip for NIC's
(http://www.alacritech.com/html/tech_review.html), which makes it possible
to take away the TCP stack from the host CPU. Therefore, the host CPU has
more performance for the applications according Alacritech.

This sounds interesting.

Unfortunately, there are two patents belonging to this solution.

Now, I'm wondering if it is possible to implement any support for these
chips in the Linux kernel. If this hardware solution does have really the
advantages described by Alacritech, it would be a pitty, if Linux couldn't
use this hardware.

What do you think about that?



Kind regards,
Andreas Hartmann
