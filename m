Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265323AbUFHVOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbUFHVOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUFHVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:14:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:7322 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265323AbUFHVO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:14:28 -0400
Date: Tue, 8 Jun 2004 14:17:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7-rc3] nr_free_files ?
Message-Id: <20040608141712.2da5ace2.akpm@osdl.org>
In-Reply-To: <1086728685.3865.3.camel@localhost.localdomain>
References: <1086728685.3865.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <fabian.frederick@skynet.be> wrote:
>
> Here's a patch removing nr_free_files.

It changes the format of /proc/sys/fs/file-nr.
