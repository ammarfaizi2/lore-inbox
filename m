Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWCTViA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWCTViA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWCTViA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:38:00 -0500
Received: from xenotime.net ([66.160.160.81]:38868 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964978AbWCTVh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:37:58 -0500
Date: Mon, 20 Mar 2006 13:40:02 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Message-Id: <20060320134002.64e52b42.rdunlap@xenotime.net>
In-Reply-To: <dvn74f$lim$1@terminus.zytor.com>
References: <20060320212338.GA11571@kroah.com>
	<20060320133230.ae739f58.rdunlap@xenotime.net>
	<dvn74f$lim$1@terminus.zytor.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 13:34:07 -0800 (PST) H. Peter Anvin wrote:

> Followup to:  <20060320133230.ae739f58.rdunlap@xenotime.net>
> By author:    "Randy.Dunlap" <rdunlap@xenotime.net>
> In newsgroup: linux.dev.kernel
> > ioctl-number.txt
> 
> Do not remove from ioctl-number.txt; those ioctl numbers should not be
> reused.

Ack.  I didn't mean that they should all be removed, but at
least reviewed/considered.

---
~Randy
