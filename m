Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVGBAKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVGBAKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 20:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVGBAKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 20:10:25 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:7592 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261667AbVGBAKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 20:10:05 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel address space on stock hosts
Date: Sat, 2 Jul 2005 02:15:50 +0200
User-Agent: KMail/1.8.1
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org> <200507020157.37593.blaisorblade@yahoo.it> <20050701170648.2762c702.akpm@osdl.org>
In-Reply-To: <20050701170648.2762c702.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507020215.51323.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 July 2005 02:06, Andrew Morton wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Friday 01 July 2005 23:58, Andrew Morton wrote:

> Well I can fix the reject if we decide that
> uml-kill-some-useless-vmalloc-tlb-flushing.patch is not to be applied, but
> it seems that there's no need.

> > However, for now it seems that I can't reproduce anyway the iptables
> > crash, and even Jeff did some testing... so it seems it's ok.

> OK..

> Now what about uml-remove-winch-sem.patch?  I have a "keep this in -mm"
> sign next to it.
Well, wait a bit for that... I'll be publishing that out in my patchset, so 
we'll get wider testing.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
