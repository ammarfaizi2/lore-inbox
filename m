Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264775AbSKEGJp>; Tue, 5 Nov 2002 01:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSKEGJp>; Tue, 5 Nov 2002 01:09:45 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:19728
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264775AbSKEGJo>; Tue, 5 Nov 2002 01:09:44 -0500
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
From: Robert Love <rml@tech9.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, andersen@codepoet.org,
       Werner Almesberger <wa@almesberger.net>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0211050056170.2336-100000@steklov.math.psu.edu>
References: <Pine.GSO.4.21.0211050056170.2336-100000@steklov.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 01:15:49 -0500
Message-Id: <1036476957.777.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 00:59, Alexander Viro wrote:

> Oh, yes it can.  Easily.
> 	* device is not network-transparent - even in principle
> 	* restricting data access would be harder - welcome to suid or
> sgid country
> 	* real killer: you think Albert would fail to produce equally
> crappy code and equally crappy behaviour?  Yeah, right.

Well I think Rik and I can handle it in our tree :)

But I agree - I do not care much for this /dev idea either.

	Robert Love

