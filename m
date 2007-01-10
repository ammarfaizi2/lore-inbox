Return-Path: <linux-kernel-owner+w=401wt.eu-S932564AbXAJAvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXAJAvt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbXAJAvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:51:49 -0500
Received: from xenotime.net ([66.160.160.81]:33635 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932564AbXAJAvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:51:48 -0500
Date: Tue, 9 Jan 2007 16:51:59 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Allexio Ju" <allexio.ju@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: description on KEYs in .config file
Message-Id: <20070109165159.f469feb0.rdunlap@xenotime.net>
In-Reply-To: <a02278b00701091640k312b4818w51f336ca3ec36933@mail.gmail.com>
References: <a02278b00701091640k312b4818w51f336ca3ec36933@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 16:40:05 -0800 Allexio Ju wrote:

> Hi,
> 
> Where can I get detail description on each KEYs in .config file?
> I'm trying to understand what are the meaning of those before turn thme on/off.

In the many Kconfig and Kconfig.* files in the kernel tree.
Or by using one of the config tools "make menuconfig/xconfig/gconfig"
and reading the Help text.

---
~Randy
