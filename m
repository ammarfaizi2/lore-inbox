Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTE3EsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTE3EsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:48:18 -0400
Received: from rth.ninka.net ([216.101.162.244]:64392 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263271AbTE3EsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:48:18 -0400
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
To: Scott A Crosby <scrosby@cs.rice.edu>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <oyd7k89cafy.fsf@bert.cs.rice.edu>
References: <Pine.LNX.4.44.0305300550130.3609-100000@localhost.localdomain>
	 <oyd7k89cafy.fsf@bert.cs.rice.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054270891.2713.5.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 May 2003 22:01:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 21:42, Scott A Crosby wrote:
> It is probably a very unusual configuration,

It is worth noting that it might even be possible to go after
this remotely. Consider a mailserver that you can someone influence
the queued mail file names for.

-- 
David S. Miller <davem@redhat.com>
