Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTDSWsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTDSWsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:48:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60112
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263489AbTDSWsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:48:39 -0400
Subject: Re: ISDN massive packet drops while DVD burn/verify
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030419193848.0811bd90.skraw@ithnet.com>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	 <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	 <20030419193848.0811bd90.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 23:01:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 18:38, Stephan von Krawczynski wrote:
> I don't buy that explanation. Reason is simple: during this all network
> connections work flawlessly, and they do have quite a lot of interrupts
> compared to ISDN. ISDN is so slow and has so few interrupts that it is quite
> unlikely in a SMP-beyond-GHz-limit box that you loose some. The ancient
> hardware days are long gone ...

I'd suggest buying his explanation, because he's right. You are
confusing quantity and latency.

