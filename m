Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUCXCuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbUCXCuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:50:05 -0500
Received: from main.gmane.org ([80.91.224.249]:28037 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262981AbUCXCt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:49:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: missing files in bk trees?
Date: Tue, 23 Mar 2004 18:50:16 -0800
Message-ID: <pan.2004.03.24.02.50.16.373654@triplehelix.org>
References: <Pine.LNX.4.58.0403232140160.7713@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 21:41:46 -0500, ameer armaly wrote:
> Hi all.
> I got the latest kernel tree from linux.bkbits.net, and I try to make
> config, and it complains about a missing zconf.tab.h.  However, it has
> decrypted the other sccs files, but for some oodd reason it can't find
> this particular one.  Suggestions would be appriciated.
> Thanks,

you need to do 'bk -r get' in the root of your checkout

-- 
Joshua Kwan


