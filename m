Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUBZNLQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbUBZNLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:11:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:25836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262782AbUBZNLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:11:14 -0500
Date: Thu, 26 Feb 2004 05:11:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: rathamahata@php4.ru, linux-kernel@vger.kernel.org, gluk@php4.ru,
       anton@megashop.ru, mfedyk@matchmail.com
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-Id: <20040226051135.17171184.akpm@osdl.org>
In-Reply-To: <20040226045331.060c07d3.akpm@osdl.org>
References: <200401311940.28078.rathamahata@php4.ru>
	<20040223142626.48938d7c.akpm@osdl.org>
	<200402241454.08210.rathamahata@php4.ru>
	<200402261519.35506.rathamahata@php4.ru>
	<20040226045331.060c07d3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Not sure why the oom-killer didn't do anything.

There's still free swap space.  The oom-killer has problems.

