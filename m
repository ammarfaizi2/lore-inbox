Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUCVA7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCVA7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:59:55 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:33928 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261524AbUCVA7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:59:55 -0500
Date: Sun, 21 Mar 2004 16:59:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Frank Cusack <fcusack@fcusack.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux sync(2) wait?
Message-ID: <20040322005953.GA12237@dingdong.cryptoapps.com>
References: <1C8xa-5lk-5@gated-at.bofh.it> <E1B54ub-00004H-OC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1B54ub-00004H-OC@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 04:30:53PM +0100, Pascal Schmidt wrote:

> No idea about NFS, but sync(1) does wait. When I push 500M out to my
> MO drive, the cp operation returns fairly quickly because I usually
> have more than 500M free memory. Then I run sync(1), which takes
> about 20 minutes before it returns.

20 minutes?!


