Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbUBCV1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbUBCV1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:27:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:46483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265899AbUBCV1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:27:49 -0500
Date: Tue, 3 Feb 2004 13:29:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philip Martin <philip@codematters.co.uk>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
Message-Id: <20040203132913.6145f4e6.akpm@osdl.org>
In-Reply-To: <87llnk2js9.fsf@codematters.co.uk>
References: <87oesieb75.fsf@codematters.co.uk>
	<20040202194626.191cbb95.akpm@osdl.org>
	<87llnk2js9.fsf@codematters.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Martin <philip@codematters.co.uk> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Could you generate a kernel profile?  Add `profile=1' to the kernel boot
> ...
> 2.4.24

OK.

> 2.6.1

Odd.  Are you really sure that it was the correct System.map?

