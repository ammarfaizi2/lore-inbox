Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269667AbUJGDZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269667AbUJGDZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 23:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269668AbUJGDZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 23:25:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269667AbUJGDZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 23:25:28 -0400
Message-ID: <4164B71A.30105@pobox.com>
Date: Wed, 06 Oct 2004 23:25:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Suresh Siddha <suresh.b.siddha@intel.com>, akpm@osdl.org, ak@suse.de
CC: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [Patch] share i386/x86_64 intel cache descriptors table
References: <20041006184723.A10900@unix-os.sc.intel.com>
In-Reply-To: <20041006184723.A10900@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have often wondered if there is any value to creating arch/x86 and 
include/asm-x86 for stuff shared between x86-64 and i386.

All this #include and cross-linking stuff gives me the willys...

	Jeff


