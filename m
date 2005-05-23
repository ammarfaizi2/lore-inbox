Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVEWRz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVEWRz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEWRx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:53:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1688 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261922AbVEWRwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:52:35 -0400
Subject: Re: [RFC/PATCH 0/4] execute in place (3rd version)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: cotte@freenet.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1116869393.12153.30.camel@cotte.boeblingen.de.ibm.com>
References: <1116869393.12153.30.camel@cotte.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1116869611.26913.1484.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 May 2005 10:33:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 10:29, Carsten Otte wrote:
> Folks,
> 
> this is the 3rd iteration of the execute in place patches. All apply
> against git tree as of today. Description of changes are in the patch
> mails. 
> Christoph, having read this version I do think you're pushing the right
> direction...
> 

Looks much cleaner from mm/filemap perspective :)

Thanks,
Badari

