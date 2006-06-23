Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932930AbWFWIL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbWFWIL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932931AbWFWIL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:11:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932930AbWFWIL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:11:58 -0400
Date: Fri, 23 Jun 2006 01:11:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MIPS] wire up tee system call
Message-Id: <20060623011148.1a57b6a7.akpm@osdl.org>
In-Reply-To: <20060623170711.3a6d1ef8.yoichi_yuasa@tripeaks.co.jp>
References: <20060623170711.3a6d1ef8.yoichi_yuasa@tripeaks.co.jp>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 17:07:11 +0900
Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:

> This patch wires up tee system call for MIPS.

Thanks.  Was the syscall tested on MIPS?
