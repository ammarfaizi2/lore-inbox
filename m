Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUAHJtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 04:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUAHJtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 04:49:12 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:26737 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264141AbUAHJtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 04:49:11 -0500
Date: Thu, 8 Jan 2004 01:50:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: xschmi00@stud.feec.vutbr.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 fix for mremap is incorrect?
Message-Id: <20040108015009.103f539e.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0401071740000.12602@home.osdl.org>
References: <3FFC5D5E.8040303@stud.feec.vutbr.cz>
	<Pine.LNX.4.58.0401071740000.12602@home.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's what you get for not actually testing your 
> patches. Thanks.

But I thought real men didn't test patches; they just
posted them to lkml and let others test them ... ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
