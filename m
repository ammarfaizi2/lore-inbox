Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTEHLhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTEHLhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:37:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:51463 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261323AbTEHLhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:37:42 -0400
Message-ID: <3EBA4529.7050507@aitel.hist.no>
Date: Thu, 08 May 2003 13:53:13 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no> <20030508080135.GK8978@holomorphy.com> <20030508100717.GN8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> 2.5.69-mm3 should suffice to test things now. If you can try that when
> you get back I'd be much obliged.

2.5.69-mm3 died in exactly the same way - the oops was identical.
I'm back to running mm2 without netfilter, to see how
stable it is.

Helge Hafting

