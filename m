Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTKRNoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTKRNmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:53 -0500
Received: from ns.suse.de ([195.135.220.2]:5586 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262760AbTKRNmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:21 -0500
To: =?iso-8859-1?q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davem@redhat.com
Subject: Re: status of ipchains in 2.6?
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com.suse.lists.linux.kernel>
	<20031028090304.GA19302@lps.ens.fr.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2003 15:31:09 +0100
In-Reply-To: <20031028090304.GA19302@lps.ens.fr.suse.lists.linux.kernel>
Message-ID: <p733cdda0ya.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Éric Brunet <Eric.Brunet@lps.ens.fr> writes:
> 
> In my case, 2.6.0-test4 is working fine.

Can you do a binary search in the versions to see which version
broke it? 

test5-test8 all had netfilter changes.

-Andi
