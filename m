Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWIBSa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWIBSa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWIBSa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:30:56 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:20881 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751026AbWIBSaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:30:55 -0400
Date: Sat, 2 Sep 2006 20:26:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 03/16] GFS2: bmap and inode functions
In-Reply-To: <20060902162547.GA23962@elte.hu>
Message-ID: <Pine.LNX.4.61.0609022025360.14813@yvahk01.tjqt.qr>
References: <1157031054.3384.788.camel@quoit.chygwyn.com>
 <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr> <20060902060939.GB16484@elte.hu>
 <Pine.LNX.4.61.0609020914570.24701@yvahk01.tjqt.qr> <20060902162345.GA23695@elte.hu>
 <20060902162547.GA23962@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>btw., it is in CodingStyle too:

It may be used in a lot of places, but there is no explicit written rule. 
That's why there actually *IS* "if(" in the kernel too.

In fact, it's better this way.



Jan Engelhardt
-- 

-- 
VGER BF report: H 0
