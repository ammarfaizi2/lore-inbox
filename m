Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVE1Lyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVE1Lyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVE1Lyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:54:50 -0400
Received: from main.gmane.org ([80.91.229.2]:42139 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262711AbVE1Lyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:54:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: PATCH: "Ok" -> "OK" in messages
Date: Sat, 28 May 2005 13:53:24 +0200
Message-ID: <yw1xzmufmurv.fsf@ford.inprovide.com>
References: <42985251.6030006@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:qHveqhgZgyBa9rxXmNXXdHBJHIM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are another couple of mistakes near your fixes.

>   		panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");

"CPU's" should be "CPUs", without the apostrophe.

>   	printk("bttv%d: Uhm. Looks like we have unusual high IRQ latencies.\n",

"unusually high" rings better in my ears.

-- 
Måns Rullgård
mru@inprovide.com

