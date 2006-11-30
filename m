Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030857AbWK3R1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030857AbWK3R1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030873AbWK3R1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:27:50 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:25736 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030857AbWK3R1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:27:49 -0500
In-Reply-To: <20061130105710.572d3c6e@frecb000686>
References: <20061129112441.745351c9@frecb000686> <20061129113212.1e614a61@frecb000686> <8BA392C6-FCCB-40BD-9CCF-3EF56C3491BD@oracle.com> <20061130105710.572d3c6e@frecb000686>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64A63298-D8EC-442A-B8D1-0DB8B6FA2E8D@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [PATCH -mm 1/5][AIO] - Rework compat_sys_io_submit
Date: Thu, 30 Nov 2006 09:27:49 -0800
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> sys_io_getevents() reads:
>
>  uh!     ^^^^^^^^^    you must be meaning sys_io_submit()?

Heh, yes, of course.  Damn these fingers!

- z
