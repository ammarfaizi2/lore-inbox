Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWJEGcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWJEGcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWJEGcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:32:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751154AbWJEGcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:32:04 -0400
Date: Wed, 4 Oct 2006 23:31:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-Id: <20061004233137.97451b73.akpm@osdl.org>
In-Reply-To: <m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 00:13:12 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Do things work better if you don't specify a vga=xxx mode?

yes, without vga=0x263 it boots.
