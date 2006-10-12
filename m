Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWJLXiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWJLXiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJLXiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:38:21 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:59615 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751321AbWJLXiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:38:20 -0400
Message-ID: <452ED1E1.5050207@oracle.com>
Date: Thu, 12 Oct 2006 16:38:09 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>,
       linux-kernel@vger.kernel.org, linux-aio <linux-aio@kvack.org>
Subject: Re: [patch] rearrange kioctx and aio_ring_info
References: <000101c6ee55$c3e121a0$db34030a@amr.corp.intel.com>
In-Reply-To: <000101c6ee55$c3e121a0$db34030a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thoughts?  Comments?  Flames?

Well, to start there should be a comment in the code warning future
readers about the specific rational behind the resulting ordering.

I'll try to think hardware about it next week.

- z
