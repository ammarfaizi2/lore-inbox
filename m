Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWGCWMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWGCWMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWGCWMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:12:19 -0400
Received: from ozlabs.org ([203.10.76.45]:32433 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751115AbWGCWMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:12:17 -0400
Date: Tue, 4 Jul 2006 08:10:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060703221005.GC31081@krispykreme>
References: <20060703030355.420c7155.akpm@osdl.org> <200607032056.28556.s0348365@sms.ed.ac.uk> <20060703131752.9eaf6c9b.akpm@osdl.org> <200607032136.55259.s0348365@sms.ed.ac.uk> <20060703135419.7c58f318.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703135419.7c58f318.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Getting better.
> 
> It would kinda help if pause_on_oops() was actually implemented on x86_64..

Now you've made me look, it seems x86 has undergone major surgery to its
oops path that most other architectures havent picked up yet.

Anton
