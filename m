Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUKDIEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUKDIEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 03:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUKDIEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 03:04:42 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4109 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262129AbUKDIEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 03:04:23 -0500
Subject: Re: kernel BUG at mm/prio_tree.c:377
From: Arjan van de Ven <arjan@infradead.org>
To: Ray Van Dolson <rayvd@digitalpath.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041104003639.GA9671@digitalpath.net>
References: <20041104003639.GA9671@digitalpath.net>
Content-Type: text/plain
Message-Id: <1099555455.16640.1.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 04 Nov 2004 09:04:16 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-03 at 16:36 -0800, Ray Van Dolson wrote:
> Description of problem:
> Running on an HP DL140, w/ Dual 2.4GHz Xeon's.  1GB of ECC DDR.  Fedora
> Core 2.

> EIP:    0060:[<021425de>]    Tainted: P  

Which binary only driver are you using ?

