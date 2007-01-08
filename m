Return-Path: <linux-kernel-owner+w=401wt.eu-S1422728AbXAHUKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbXAHUKw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbXAHUKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:10:52 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:3562 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422728AbXAHUKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:10:51 -0500
Date: Mon, 8 Jan 2007 21:10:54 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "J.H." <warthog9@kernel.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-Id: <20070108211054.9aac9b74.khali@linux-fr.org>
In-Reply-To: <45858B3A.5050804@oracle.com>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org>
	<458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<45858B3A.5050804@oracle.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 10:23:54 -0800, Randy Dunlap wrote:
> I can't really say since I have no performance/profile data to base
> it on.  There has been some noise about (not) providing mirror services
> for distros.  Is that a big cpu/memory consumer?  If so, then is that
> something that kernel.org could shed over some N (6 ?) months?
> I understand not dropping it immediately, but it seems to be more of
> a convenience rather than something related to kernel development.

I'd second that request. Mirroring out distros isn't the primary
objective of kernel.org, and we should focus on giving the kernel
developers what they need to do their job. Distro mirroring is best
handled by other sites around the world, and by bittorrent. I doubt
anyone out there will notice if kernel.org stops mirroring these
distros, while kernel developpers hopefully will.

-- 
Jean Delvare
