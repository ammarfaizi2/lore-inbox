Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUHYErr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUHYErr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbUHYEr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:47:29 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:32286 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268084AbUHYErU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:47:20 -0400
Date: Wed, 25 Aug 2004 06:48:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Network Mailing List <linux-net@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: Linux-2.6.9-rc1 netfilter compile problems
Message-ID: <20040825044801.GB7310@mars.ravnborg.org>
Mail-Followup-To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Network Mailing List <linux-net@vger.kernel.org>,
	netfilter-devel@lists.netfilter.org
References: <20040824205315.77265dcd@laptop.delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824205315.77265dcd@laptop.delusion.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 08:53:15PM -0700, Udo A. Steinberg wrote:
> 
> 
> Problem #1:
> ----------
> 
> uas@laptop:~/linux-2.6.9-rc1> make
> /bin/sh: line 1: [: too many arguments
>   SPLIT   include/linux/autoconf.h -> include/config/*

Fixed in Linus' tree - so should be present in next snapshot.

	Sam
