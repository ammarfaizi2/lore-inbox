Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTKCUVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTKCUVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:21:12 -0500
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:18825 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263125AbTKCUVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:21:10 -0500
Subject: Re: IA64/x86-64 and execution protection support?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: trelane@digitasaru.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031103144932.GC31953@digitasaru.net>
References: <20031103144932.GC31953@digitasaru.net>
Content-Type: text/plain
Message-Id: <1067890869.17174.17.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 03 Nov 2003 12:21:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-03 at 06:49, Joseph Pingenot wrote:

> Does the Linux kernel have support for preventing execution of certain
>   memory regions on those architectures?

It does on x86_64, yes.  This can be enabled or disabled via command
line options.

	<b

