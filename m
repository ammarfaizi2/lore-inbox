Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTEHKsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 06:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTEHKsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 06:48:50 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:30470 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261301AbTEHKsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 06:48:50 -0400
Message-ID: <3EBA39B9.8040008@aitel.hist.no>
Date: Thu, 08 May 2003 13:04:25 +0200
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
>
> 2.5.69-mm3 should suffice to test things now. If you can try that when
> you get back I'd be much obliged.

I'll do.
It'll probably work, for a 2.5.69-mm2 without netfilter works fine.
At least it stays up for hours where 2.5.69-mm2 with netfilter died
in 15 minutes.

Helge Hafting

