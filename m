Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbTKNRxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbTKNRxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:53:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:8904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264640AbTKNRxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:53:09 -0500
Date: Fri, 14 Nov 2003 09:57:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jack Steiner <steiner@sgi.com>
Cc: kiran@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-Id: <20031114095737.40439f2c.akpm@osdl.org>
In-Reply-To: <20031114174535.GA30388@sgi.com>
References: <20031110215844.GC21632@sgi.com>
	<20031111082915.GC1130@llm08.in.ibm.com>
	<20031111115804.4aaafd28.akpm@osdl.org>
	<20031114174535.GA30388@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
>
> Probably too late for 2.6.0

Hard to see how it can break anything; I'll queue it up, thanks.

> but here is a patch that disables noirqdebug:

No update to Documentation/kernel-parameters.txt!  No cookie for you.
