Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbTGFAdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 20:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbTGFAdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 20:33:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266577AbTGFAdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 20:33:42 -0400
Date: Sat, 5 Jul 2003 17:49:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: paterley <paterley@DrunkenCodePoets.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2
Message-Id: <20030705174915.09173756.akpm@osdl.org>
In-Reply-To: <20030705200133.3aa1da18.paterley@DrunkenCodePoets.com>
References: <20030705132528.542ac65e.akpm@osdl.org>
	<20030705175830.4ccfead8.paterley@DrunkenCodePoets.com>
	<20030705182359.269b404d.paterley@DrunkenCodePoets.com>
	<20030705160445.2ab1e0ec.akpm@osdl.org>
	<20030705200133.3aa1da18.paterley@DrunkenCodePoets.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paterley <paterley@DrunkenCodePoets.com> wrote:
>
> same oops, at the same point with smbfs compiled in.  

And what happens if you disable smbfs altogether?
