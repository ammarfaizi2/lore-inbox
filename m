Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWHSD4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWHSD4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 23:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWHSD4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 23:56:50 -0400
Received: from xenotime.net ([66.160.160.81]:52416 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932115AbWHSD4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 23:56:50 -0400
Date: Fri, 18 Aug 2006 20:59:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "jeff shia" <tshxiayu@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: can I insmod a module if my hardware donot support it?
Message-Id: <20060818205949.0bba8b10.rdunlap@xenotime.net>
In-Reply-To: <7cd5d4b40608182012p433ad168oa2ab1688aa9209b4@mail.gmail.com>
References: <7cd5d4b40608182012p433ad168oa2ab1688aa9209b4@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 11:12:52 +0800 jeff shia wrote:

> Hello,
> 
> If I have not a 8139 network card, can I insmod the 8139too.o
> module?
> 
> Thank you in advance.

I just did:
8139too Fast Ethernet driver 0.9.27

# lsmod
Module                  Size  Used by
8139too                44800  0


---
~Randy
