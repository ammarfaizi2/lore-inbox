Return-Path: <linux-kernel-owner+willy=40w.ods.org-S289556AbUKBAR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S289556AbUKBAR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291096AbUKBAR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:17:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:3279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S385249AbUKBARi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:17:38 -0500
Date: Mon, 1 Nov 2004 16:21:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/14] FRV: Fujitsu FR-V CPU arch implementation
Message-Id: <20041101162121.12aebbbd.akpm@osdl.org>
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhowells@redhat.com wrote:
>
> The attached patch provides an architecture implementation for the Fujitsu FR-V
> CPU series, configurably as Linux or uClinux.

Who developed this?

Who is maintaining it, and via what mailing list?

I didn't notice a MAINTAINERS record.  Was there one?

How widespread is the usage of this architecture?

Please convince us that this is not a piece of code which nobody will use
and which will fall into an unmaintained lump.

Thanks.
