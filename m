Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUI0Un6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUI0Un6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUI0Umk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:42:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40839 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267344AbUI0Ui7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:38:59 -0400
Date: Mon, 27 Sep 2004 13:38:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: patch] inotify: use bitmap.h functions
Message-Id: <20040927133801.288b4090.pj@sgi.com>
In-Reply-To: <1096316535.30503.119.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	<1096305177.30503.65.camel@betsy.boston.ximian.com>
	<20040927124836.2983ff9b.pj@sgi.com>
	<1096316535.30503.119.camel@betsy.boston.ximian.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you mean bitmap_zero(), but yah.  Agreed.
> 
> John, here is a patch to use the bitmap.h functions to manipulate the
> bitmap.

thanks

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
