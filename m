Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWIXO0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWIXO0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWIXO0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:26:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:18521 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750900AbWIXOZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:25:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=q8NmEYk5pwnxagtpT//Y/2fdNATatD452Y0scZWoMGf/cFwV0NxgZl7MQ30595GGMRKnk75pmZ9o/vlXNfKipTOQAGVVm1BdBtCGk2nRsOcvYY+YXv6UYstLHZH/kWb05ObkEdxlrNGpShRjrWgDAxFJKXAd9cII3jyJvH8DXQA=
Date: Sun, 24 Sep 2006 16:25:52 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060924162552.0cb1ece8.diegocg@gmail.com>
In-Reply-To: <358885143.12940@ustc.edu.cn>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<358882397.20533@ustc.edu.cn>
	<20060921165918.af7a5a63.akpm@osdl.org>
	<358885143.12940@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 22 Sep 2006 08:32:23 +0800,
Fengguang Wu <fengguang.wu@gmail.com> escribió:

> FYI: I attached a little presentation work, one for the boot time
> stuff, another for the readahead patch.

A nice and clean way to collect I/O traces that it's not mentioned in
the boot_linux_faster.pdf paper would be to use kprobes + systemtap.

