Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUHWSdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUHWSdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUHWScz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:32:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:41862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266550AbUHWS3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:29:21 -0400
Date: Mon, 23 Aug 2004 11:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: dhowells@redhat.com, rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4 (strange behavior on dual Opteron w/ NUMA)
Message-Id: <20040823112718.628eb84e.akpm@osdl.org>
In-Reply-To: <20040823084640.1195f4f3.rddunlap@osdl.org>
References: <200408221620.00692.rjw@sisk.pl>
	<20040822013402.5917b991.akpm@osdl.org>
	<798.1093274973@redhat.com>
	<20040823084640.1195f4f3.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> This oops is fixed by this trivial patch:
> 
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=109313574928853&w=2

But that patch was in -mm4.
