Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVCOCJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVCOCJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVCOCJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:09:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:39058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261414AbVCOCJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:09:36 -0500
Date: Mon, 14 Mar 2005 18:09:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback "nobh" option
Message-Id: <20050314180917.07f7ac58.akpm@osdl.org>
In-Reply-To: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Here is the 2.6.11-mm3 version of patch for adding "nobh"
>  support for ext3 writeback mode.

Care to update Documentation/filesystems/ext3.txt?

>  Can you include it in -mm ?

Spose so.

Did you have performance and resource consumption numbers to justify it?  I
think I asked that before and promptly forgot the answer, which is a good
reason for taking some care over changelog maintenance...
