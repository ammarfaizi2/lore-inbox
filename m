Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWHGPvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWHGPvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWHGPvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:51:23 -0400
Received: from xenotime.net ([66.160.160.81]:35987 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932187AbWHGPvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:51:23 -0400
Date: Mon, 7 Aug 2006 08:54:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Gregoire Favre <gregoire.favre@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lxdialog under linux-2.6.18-rc3-mm2 ?
Message-Id: <20060807085403.32bd61ca.rdunlap@xenotime.net>
In-Reply-To: <20060807112353.GC9198@gmail.com>
References: <20060807112353.GC9198@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 13:23:53 +0200 Gregoire Favre wrote:

> Hello,
> 
> in order to compil hg pull -u http://linuxtv.org/hg/v4l-dvb one need
> lxdialog, which seems to be removed in 2.6.18-rc3-mm2.
> 
> Any idea why ?
> 
> Please CC to me as I am not on this ml :-)

lxdialog was merged into kconfig instead of being a
separate program.

---
~Randy
