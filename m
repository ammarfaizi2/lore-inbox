Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267120AbUBRX6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267129AbUBRX6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:58:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:49048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267120AbUBRX63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:58:29 -0500
Date: Wed, 18 Feb 2004 15:58:19 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: [SELINUX] Event notifications via Netlink
Message-ID: <20040218155819.J1652@build.pdx.osdl.net>
References: <20040218144346.B22989@build.pdx.osdl.net> <Xine.LNX.4.44.0402181845520.29323-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0402181845520.29323-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Wed, Feb 18, 2004 at 06:47:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> 
> Reaching this would be incorrect use of a kernel API, leading to 
> malfunctioning security code, so I feel that a BUG() is appropriate.

Fair enough.  Just making sure it wasn't leftover from testing or something.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
