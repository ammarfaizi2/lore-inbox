Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933753AbWK3KEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933753AbWK3KEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933817AbWK3KEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:04:44 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:59050 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S933753AbWK3KEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:04:43 -0500
Date: Thu, 30 Nov 2006 11:04:46 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: suparna@in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 5/5][AIO] - Listio support
Message-ID: <20061130110446.3cef5722@frecb000686>
In-Reply-To: <20061130082535.GA1867@in.ibm.com>
References: <20061129112441.745351c9@frecb000686>
	<20061129113326.071092cf@frecb000686>
	<20061130082535.GA1867@in.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 11:11:55,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 11:11:56,
	Serialize complete at 30/11/2006 11:11:56
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 13:55:36 +0530, Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> 
> Could you mention changes in this patch since your last post ? 

  Aside from adding compat support, nothing changed here.

> 
> BTW, if I try to apply your patches, I get the following error (diffstat
> works ok, but something has mangled the patch, maybe mailer problems ?)
> 
> patch: **** Only garbage was found in the patch input.
> 

  My fault, didn't notice that my mailer did wrap the inserted patches.
Arghhh, sorry. Next round soon.


