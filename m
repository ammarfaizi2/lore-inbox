Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbUABDFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 22:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbUABDFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 22:05:13 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:56683 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263345AbUABDFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 22:05:09 -0500
Date: Thu, 1 Jan 2004 19:05:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040101190532.1ce4b447.pj@sgi.com>
In-Reply-To: <1073004403.1376.14.camel@nidelv.trondhjem.org>
References: <20040101043333.186a3268.pj@sgi.com>
	<1072977297.1399.14.camel@nidelv.trondhjem.org>
	<20040101151516.236cb610.pj@sgi.com>
	<1073004403.1376.14.camel@nidelv.trondhjem.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You mentioned Richard Gooch's name cropping up in the broken code,

No, no, no.  I was just using his name in a hypothetical example,
as the most famous author of code we all love to hate.

The warnings were everywhere.  See Andi Kleen's post stating that a bug
in gcc 3.3.0 enabled that warning in -Wall by mistake.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
