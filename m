Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVJZIKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVJZIKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVJZIKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:10:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932586AbVJZIKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:10:00 -0400
Date: Wed, 26 Oct 2005 01:09:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, magnus@valinux.co.jp, pj@sgi.com
Subject: Re: [PATCH] CPUSETS: remove SMP dependency
Message-Id: <20051026010922.5a8f70fe.akpm@osdl.org>
In-Reply-To: <20051026075345.21014.53533.sendpatchset@cherry.local>
References: <20051026075345.21014.53533.sendpatchset@cherry.local>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> wrote:
>
> Remove the SMP dependency from CPUSETS.


Why?
