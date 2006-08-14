Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWHNBxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWHNBxl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWHNBxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:53:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751786AbWHNBxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:53:40 -0400
Date: Sun, 13 Aug 2006 18:53:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@google.com>
Cc: David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-Id: <20060813185309.928472f9.akpm@osdl.org>
In-Reply-To: <44DFD262.5060106@google.com>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 18:31:14 -0700
Daniel Phillips <phillips@google.com> wrote:

> But to solve the whole problem

What problem?  Has anyone come up with a testcase which others can
reproduce?
