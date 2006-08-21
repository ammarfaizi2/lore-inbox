Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWHUHti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWHUHti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWHUHti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:49:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:5299 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030288AbWHUHth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:49:37 -0400
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus@valinux.co.jp>
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
Date: Mon, 21 Aug 2006 09:48:40 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Christoph@sc8-sf-spam2-b.sourceforge.net,
       List <linux-kernel@vger.kernel.org>, Kirill Korotaev <dev@sw.ru>,
       Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux@sc8-sf-spam2-b.sourceforge.net, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org
References: <44E33893.6020700@sw.ru> <20060818094248.cdca152d.akpm@osdl.org> <1156127920.21411.32.camel@localhost>
In-Reply-To: <1156127920.21411.32.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608210948.40870.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You may be looking for the NUMA emulation patches posted here:
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=112806587501884&w=2
> 
> There is a slightly updated x86_64 version here too:
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=113161386520342&w=2

Hmm, I must have missed that version. Seems like a improvement. Best you
resubmit it, although I'll probably only take it after the .19 merge


-Andi
