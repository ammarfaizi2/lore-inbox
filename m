Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUIVW24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUIVW24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUIVW2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:28:55 -0400
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:62948 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S267985AbUIVW1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:27:39 -0400
Message-ID: <4151FC58.2050402@bigpond.net.au>
Date: Thu, 23 Sep 2004 08:27:36 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
References: <20040922131210.6c08b94c.akpm@osdl.org>
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> - Added Peter Williams' Single Priority Array (SPA) O(1) CPU Scheduler, aka
>   the "zaphod" cpu scheduler.
> 
>   It has a number of tunables and lots of documentation - see the changelog
>   entry in zaphod-scheduler.patch for details.
> 

There is a primitive PyGTK/Glade GUI that can be used to view and set 
(when run as root) the ZAPHOD scheduler's tunables at:

<http://prdownloads.sourceforge.net/cpuse/gcpuctl_hydra-1.4.tar.gz?download>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

