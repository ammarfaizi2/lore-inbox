Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163788AbWLGXCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163788AbWLGXCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163794AbWLGXCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:02:33 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:35156 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163788AbWLGXC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:02:29 -0500
In-Reply-To: <000101c7198d$9a9fde40$ff0da8c0@amr.corp.intel.com>
References: <000101c7198d$9a9fde40$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2A197D0D-89EA-4769-9E51-162FD496134A@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Chris Mason'" <chris.mason@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] optimize o_direct on block device - v3
Date: Thu, 7 Dec 2006 15:02:36 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (my monkey test code is on http://kernel-perf.sourceforge.net/ 
> diotest).

Nice.

Do you have any interest in working with the autotest ( http:// 
test.kernel.org/autotest ) guys to get your tests into their rotation?

- z
