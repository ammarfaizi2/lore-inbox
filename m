Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTIAUWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTIAUWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:22:53 -0400
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:14006 "EHLO
	procyon.nix.homeunix.net") by vger.kernel.org with ESMTP
	id S263258AbTIAUWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:22:52 -0400
Date: Mon, 1 Sep 2003 22:22:50 +0200
From: Henrik Persson <nix@syndicalist.net>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: pclark@SLAC.Stanford.EDU, linux-kernel@vger.kernel.org
Subject: Re: orinoco wireless driver
In-Reply-To: <20030901174437.GK10584@conectiva.com.br>
References: <x34vfscwgq8.fsf@bbrcu5.slac.stanford.edu>
	<20030901174437.GK10584@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20030901202251.066AD3FA2A@procyon.nix.homeunix.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 14:44:37 -0300
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

> humm, I saw this lots of times, care to try, after it is detected as
> "memory" to do this:
> 
> cardctl eject
> cardctl insert
> 
> and see if gets correctly detected this turn? works for me.

And restart cardmgr a couple of times and then ejecting and inserting..
Those procedures are needed here. ;)

-- 
Henrik Persson  nix@syndicalist.net
