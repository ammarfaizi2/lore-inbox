Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUKBKJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUKBKJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 05:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKBKJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 05:09:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:50149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261544AbUKBKJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 05:09:09 -0500
Date: Tue, 2 Nov 2004 03:07:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 11/14] FRV: Add FDPIC ELF binary format driver
Message-Id: <20041102030703.6e16a5bb.akpm@osdl.org>
In-Reply-To: <200411011930.iA1JULwr023235@warthog.cambridge.redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	<200411011930.iA1JULwr023235@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch breaks the x86_64 build in gruesome ways.
