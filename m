Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUKCWkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUKCWkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbUKCWhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:37:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:21179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261935AbUKCWZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:25:50 -0500
Date: Wed, 3 Nov 2004 14:29:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: truncate issues in 2.6.10-rc1-mm2 ?
Message-Id: <20041103142928.609a9c64.akpm@osdl.org>
In-Reply-To: <1099518398.21024.24.camel@dyn318077bld.beaverton.ibm.com>
References: <1099518398.21024.24.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I seem to be running into truncate issues on 2.6.10-rc1-mm2.
> Kernel compile hangs. Here is the sysrq-t output for the
> process. Do you know ?

Beats me.  If we can find a workload which reproduces it in a sane amount
of time I can do a binary search.

