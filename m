Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUFVSXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUFVSXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbUFVSWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:22:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:43748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265232AbUFVSRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:17:12 -0400
Date: Tue, 22 Jun 2004 11:15:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [PATCH] consolidate in kernel configuration
Message-Id: <20040622111559.1fa0dc99.akpm@osdl.org>
In-Reply-To: <200406221557.i5MFv3YN020056@voidhawk.shadowen.org>
References: <200406221557.i5MFv3YN020056@voidhawk.shadowen.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> This patch removes the plain text version of the configuration and
>  updates the extraction tools to locate and use the gzip'd version
>  of the file.

Andy, this needs rework for top-level-Makefile changes which Linus recently
merged.
