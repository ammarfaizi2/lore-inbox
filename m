Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVC1EHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVC1EHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 23:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVC1EHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 23:07:48 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:30396 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261681AbVC1EHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 23:07:45 -0500
Date: Sun, 27 Mar 2005 20:07:30 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
 -fs/ext2/
Message-Id: <20050327200730.54e8dafb.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	<Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	<1111825958.6293.28.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	<Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	<1111881955.957.11.camel@mindpipe>
	<Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	<20050327065655.6474d5d6.pj@engr.sgi.com>
	<Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan - please don't trim the CC lists when responding on lkml.
Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
