Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263644AbUDFHKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUDFHKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:10:39 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:32865 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263644AbUDFHKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:10:38 -0400
Date: Tue, 6 Apr 2004 00:08:02 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040406000802.1323a7b6.pj@sgi.com>
In-Reply-To: <407252F2.3090102@yahoo.com.au>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
	<20040405230601.62c0b84c.pj@sgi.com>
	<40724CF4.5090705@yahoo.com.au>
	<20040405233415.2c7c3a96.pj@sgi.com>
	<407252F2.3090102@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> I think Linus likes keeping struct around if something is ...

makes sense - thanks

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
