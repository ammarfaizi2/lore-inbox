Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbTEGKeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTEGKeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:34:20 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:24593 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263072AbTEGKeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:34:20 -0400
Message-ID: <3EB8E4CC.8010409@aitel.hist.no>
Date: Wed, 07 May 2003 12:49:48 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
References: <20030506232326.7e7237ac.akpm@digeo.com>	 <3EB8DBA0.7020305@aitel.hist.no> <1052304024.9817.3.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 2003-05-07 at 03:10, Helge Hafting wrote:
> 
>>2.5.69-mm1 is fine, 2.5.69-mm2 panics after a while even under very
>>light load.
> 
> 
> Do you have AF_UNIX built modular?

No, I compile everything into a monolithic kernel.
I don't even enable module support.

Helge Hafting




