Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313316AbSDKJDw>; Thu, 11 Apr 2002 05:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313553AbSDKJDv>; Thu, 11 Apr 2002 05:03:51 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:51599 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S313316AbSDKJDv>;
	Thu, 11 Apr 2002 05:03:51 -0400
Date: Thu, 11 Apr 2002 11:03:47 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: andrea@suse.de
cc: linux-kernel@vger.kernel.org
Subject: rb_tree methods export request
Message-ID: <Pine.LNX.4.10.10204111059020.15162-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

I write to you as to maintainer of rb_tree code in 2.4. I'm
just finishing module (QoS HTB scheduler) where I need to use 
balanced tree and your rb_tree implementation seems as the best
one for it.
Only problem is that rb_delete and athers are not exported so that
I can't use them in the module.
Is there some problem to export the symbols or should I duplicate
the code ?

thanks, devik
http://luxik.cdi.cz/~devik/qos/

