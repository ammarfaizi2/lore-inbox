Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbUKUCsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbUKUCsb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 21:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbUKUCsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 21:48:31 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22155 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261754AbUKUCs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 21:48:27 -0500
Message-ID: <41A00205.1020704@namesys.com>
Date: Sat, 20 Nov 2004 18:48:37 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
References: <16797.41728.984065.479474@samba.org>	<419E1297.4080400@namesys.com>	<16798.31565.306237.930372@samba.org>	<419ECAB5.10203@namesys.com>	<16798.59519.63931.494579@samba.org>	<419F6D1F.10001@namesys.com> <16799.62734.463565.38876@samba.org>
In-Reply-To: <16799.62734.463565.38876@samba.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you be willing to do some variation on it that scaled itself to 
the size of the machine, and generated disk load rather than fitting in ram?

I hope you understand my reluctance to optimize for tests that fit into 
ram.....


Thanks,

Hans

>
>Finally, I should note that Spec is considering adding CIFS
>benchmarking to their suite of benchmarks. Interestingly, they are
>looking at using something based on my nbench tool, or something close
>to it, so eventually nbench might become the more "official"
>benchmark. That would certainly be an interesting turn of events :)
>
>Cheers, Tridge
>
>
>  
>

