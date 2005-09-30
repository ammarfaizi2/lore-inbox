Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVI3PZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVI3PZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbVI3PZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:25:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6873 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030334AbVI3PZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:25:33 -0400
Subject: Re: [PATCH 05/07] i386: sparsemem on pc
From: Dave Hansen <haveblue@us.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050930073258.10631.74982.sendpatchset@cherry.local>
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <20050930073258.10631.74982.sendpatchset@cherry.local>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 08:25:29 -0700
Message-Id: <1128093929.6145.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
> This patch for enables and fixes sparsemem support on i386. This is the
> same patch that was sent to linux-kernel on September 6:th 2005, but this 
> patch includes up-porting to fit on top of the patches written by Dave Hansen.

I'll post a more comprehensive way to do this in just a moment.  

	Subject: memhotplug testing: hack for flat systems

-- Dave

