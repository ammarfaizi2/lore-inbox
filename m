Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbTFLWmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbTFLWmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:42:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:28927 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265031AbTFLWmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:42:00 -0400
Date: Thu, 12 Jun 2003 15:51:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-Id: <20030612155148.60a39787.akpm@digeo.com>
In-Reply-To: <20030612225040.GA1492@kroah.com>
References: <3EE8D038.7090600@mvista.com>
	<20030612214753.GA1087@kroah.com>
	<20030612150335.6710a94f.akpm@digeo.com>
	<20030612225040.GA1492@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 22:55:45.0742 (UTC) FILETIME=[C22F66E0:01C33135]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> <handwaving>

heh.

Thought about adding a sequence number to the /sbin/hotplug argument list?

