Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759063AbWK3IBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759063AbWK3IBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759059AbWK3IBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:01:39 -0500
Received: from main.gmane.org ([80.91.229.2]:15059 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1759058AbWK3IBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:01:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@gmail.com>
Subject: Re: Linux 2.6.19
Date: Thu, 30 Nov 2006 09:01:22 +0100
Message-ID: <20061130090122.6d572f90@holly>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chaos.mk.cvut.cz
X-Newsreader: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed the VIA PATA patch to be able to boot:

http://lkml.org/lkml/2006/6/18/165

Also, atakbd.c produced lots of "Spurious ACK" messages on kernel panic
when I misspecified the root fs, which made the real problem a little
more difficult to find.

-- 
Jindrich Makovicka

