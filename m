Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbUCVVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbUCVVpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:45:25 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:59482 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263693AbUCVVpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:45:24 -0500
Date: Mon, 22 Mar 2004 13:44:13 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: akpm@osdl.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-Id: <20040322134413.1bf1f945.pj@sgi.com>
In-Reply-To: <20040322202118.GA27281@tsunami.ccur.com>
References: <20040322202118.GA27281@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also prepended comments to the bitmap_shift_* functions defining what

Nice work.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
