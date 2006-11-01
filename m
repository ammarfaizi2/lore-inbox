Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWKAUtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWKAUtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbWKAUtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:49:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751036AbWKAUtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:49:01 -0500
Date: Wed, 1 Nov 2006 12:48:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc4-mm1
Message-Id: <20061101124827.1559ac22.akpm@osdl.org>
In-Reply-To: <200611011435.09740.len.brown@intel.com>
References: <20061031015121.dfc7e02a.akpm@osdl.org>
	<200611011435.09740.len.brown@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 14:35:09 -0500
Len Brown <len.brown@intel.com> wrote:

> On Tuesday 31 October 2006 04:51, Andrew Morton wrote:
> 
> > - The ACPI tree has been dropped due to Rafael's testing failures.
> 
> Rafael has confirmed that the latest ACPI tree works on his system,
> please resume pulling the ACPI tree into the -mm tree.

OK.  I have the six build fixes which I think were all against the
now-removed ACPICA code.  I'll send them over then drop them.

