Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVDVKYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVDVKYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 06:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDVKYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 06:24:53 -0400
Received: from [81.2.110.250] ([81.2.110.250]:8603 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262020AbVDVKYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 06:24:52 -0400
Subject: Re: 2.6.10-ac10 oops in journal_commit_transaction
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>,
       Brice Figureau <brice+lklm@daysofwonder.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050421222946.GK23013@shell0.pdx.osdl.net>
References: <894E37DECA393E4D9374E0ACBBE74270013E8BA0@pdsmsx402.ccr.corp.intel.com>
	 <20050421222946.GK23013@shell0.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114161831.3870.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Apr 2005 10:23:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-21 at 23:29, Chris Wright wrote:
> I believe it's fixed in 2.6.11-ac, and we fixed it in the current stable
> 2.6.11.7 tree.  The following patch is what went into 2.6.11.7:

2.6.11.7 or 2.6.11ac7 (ie 2.6.11.7-ac 8)) both have this fixed.
