Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTKHIyR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 03:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTKHIyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 03:54:17 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:30212 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261662AbTKHIyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 03:54:16 -0500
Date: Sat, 8 Nov 2003 08:54:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] forcedeth
Message-ID: <20031108085415.C18856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FAC837F.2070601@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FAC837F.2070601@gmx.net>; from c-d.hailfinger.kernel.2003@gmx.net on Sat, Nov 08, 2003 at 06:47:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 06:47:43AM +0100, Carl-Daniel Hailfinger wrote:
> Attached is forcedeth: A new driver for the ethernet interface of the
> NVIDIA nForce chipset, licensed under GPL.

Any chance to give the driver a more descriptive name, say nforce_eth?
Traditionally we tend to name like drivers after the hardware's name or
codename, not the development methology used.

