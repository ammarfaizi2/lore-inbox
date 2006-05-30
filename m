Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWE3BbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWE3BbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWE3BbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932104AbWE3Bat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:30:49 -0400
Date: Mon, 29 May 2006 18:35:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-Id: <20060529183503.6bc60a83.akpm@osdl.org>
In-Reply-To: <20060529212109.GA2058@elte.hu>
References: <20060529212109.GA2058@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:21:09 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> We are pleased to announce the first release of the "lock dependency 
> correctness validator" kernel debugging feature

What are the runtime speed and space costs of enabling this?
