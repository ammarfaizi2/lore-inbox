Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWEJUuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWEJUuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWEJUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:50:51 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:32899 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964817AbWEJUuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:50:50 -0400
Message-ID: <44625224.3020104@us.ibm.com>
Date: Wed, 10 May 2006 13:50:44 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       bcrl@kvack.org, cel@citi.umich.edu
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>	<1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com>	<20060509120105.7255e265.akpm@osdl.org>	<20060509190310.GA19124@lst.de> <20060509121305.0840e770.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

If you haven't picked these patches into -mm yet, can you hold off till
tomorrow ? I have an updated version with few minor fixes + I am almost
ready with the filemap.c cleanups. I am currently testing those and haven't
found any blockers.

Thanks,
Badari


