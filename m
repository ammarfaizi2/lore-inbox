Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTESQv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTESQv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:51:27 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:20461 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S262294AbTESQv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:51:26 -0400
Message-ID: <3EC90E92.4030507@mvista.com>
Date: Mon, 19 May 2003 12:04:18 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Christoph Hellwig <hch@infradead.org>, linux.nics@intel.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add boot command line parsing for the e100 driver
References: <3EC901BB.8040100@mvista.com> <20030519171714.A22487@infradead.org> <20030519163052.GB17048@gtf.org> <20030519173323.A22670@infradead.org> <20030519164019.GC17048@gtf.org>
In-Reply-To: <20030519164019.GC17048@gtf.org>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>>instead of adding such horrible cruft Corey did it should just use the
>>proper API.
>>    
>>
>
>An API already exists, and it is source compatible between 2.4 and 2.5:
>ethX=.... on the kernel command line.
>
>The proper patch would pick up options from there.
>
Can you tell me where this is?  I found the "ether=xxx" and
"netdev=xxx", but they are not suitible.  I also could not find
"module_parame" anywhere on google or in the kernel.

-Corey

