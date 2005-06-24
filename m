Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVFXPrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVFXPrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbVFXPrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:47:18 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:38846 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S263035AbVFXPpu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:45:50 -0400
Date: Fri, 24 Jun 2005 08:45:40 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, piotrowskim@trex.wsi.edu.pl
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool
Message-Id: <20050624084540.22a8785b.rdunlap@xenotime.net>
In-Reply-To: <42BC0DCD.8020206@g-house.de>
References: <42BBE593.9090407@trex.wsi.edu.pl>
	<42BC0DCD.8020206@g-house.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005 15:42:37 +0200 Christian wrote:

| Micha__ Piotrowski schrieb:
| > If you know something about bash scripting you can review it, add some 
| > useful features and make some optimalisations. Or just send me an idea.
| 
| why does it have to be run as root? the only things i see missing are 
| the "Capabilities" output from lspci -vvv when running as a user.

'lsusb -v' also needs root permissions, but yes, other than those
2 commands, root is not needed AFAIK.

| otherwise: great script, could be even included in ../scripts ?


---
~Randy
