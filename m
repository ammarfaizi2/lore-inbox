Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbRFURkW>; Thu, 21 Jun 2001 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265067AbRFURkM>; Thu, 21 Jun 2001 13:40:12 -0400
Received: from h0050da0a579c.ne.mediaone.net ([24.218.68.6]:3712 "EHLO
	sexorcisto.net") by vger.kernel.org with ESMTP id <S265066AbRFURkA>;
	Thu, 21 Jun 2001 13:40:00 -0400
Date: Thu, 21 Jun 2001 13:40:02 -0400 (EDT)
From: Vallimar <vallimar@mediaone.net>
X-X-Sender: <vallimar@sexorcisto.net>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with patch 2.4.6pre5
Message-ID: <Pine.LNX.4.33.0106211336310.1063-100000@sexorcisto.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  After applying this patch, I suddenly got flooded by iptables with
tonnes of messages being flagged as TAINTED by my firewall.  I previously
ran 2.4.6pre3 with no problems whatsoever, so I think the additional
network driver updates might have caused a problem?  I'm using
a 3c905b if that helps any.  Sorry if this has already been reported,
I hadn't been subscribed before and I didn't see any archives that
I know of up-to-date to see if it had.  If you could, please cc me
and let me know if it's truly a kernel problem, or I just have something
configured wrong that is only now showing up.

		Thanks,
		  Troy Edwards


