Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWELKGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWELKGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWELKGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:06:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751110AbWELKGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:06:18 -0400
Date: Fri, 12 May 2006 03:03:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
Message-Id: <20060512030309.3a94bea8.akpm@osdl.org>
In-Reply-To: <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>  drivers/usb/gadget/inode.c        |   71 +++++++++++++++++++++++++++-----------

The changes in this file don't even approximately vaguely have the
remotest chance of compiling.  Please send fix.

