Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRDFPLO>; Fri, 6 Apr 2001 11:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbRDFPLE>; Fri, 6 Apr 2001 11:11:04 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:52670 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S131672AbRDFPKv>; Fri, 6 Apr 2001 11:10:51 -0400
Date: Fri, 6 Apr 2001 08:09:36 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: <gibbs@scsiguy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Seems to be a lot of confusion about aic7xxx in linux 2.4.3
Message-ID: <Pine.LNX.4.33.0104060803450.12216-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing a lot of complaints about aic7xxx in the 2.4.3 kernel.  I
think that people are missing the crucial point: aic7xxx won't compile if
you patch up from 2.4.2, but if you download the complete 2.4.3 tarball,
it compiles fine.

So, I conclude that the patch was created incorrectly, or that something
changed between cutting the patch and the tarball.

-jwb

