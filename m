Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266464AbUAOJ03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 04:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266468AbUAOJ03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 04:26:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:22221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266464AbUAOJ02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 04:26:28 -0500
Date: Thu, 15 Jan 2004 01:26:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Der Herr Hofrat <der.herr@hofr.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 SCHED_RR/SCHED_FIFO strangness .
Message-Id: <20040115012624.19da7712.akpm@osdl.org>
In-Reply-To: <200401140745.i0E7j7q29175@hofr.at>
References: <200401140745.i0E7j7q29175@hofr.at>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Der Herr Hofrat <der.herr@hofr.at> wrote:
>
>  The strange thing is that SCHED_FIFO runs always return worse results than
>   SCHED_RR runs under even moderate load (one find / in an endless loop, system
>   otherwise idle) - any ideas what is causing this ?

Can you send us the entire test app?
