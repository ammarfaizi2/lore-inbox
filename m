Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUIXEX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUIXEX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUIXEX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:23:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:39053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267170AbUIXEX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:23:26 -0400
Date: Thu, 23 Sep 2004 21:21:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ray Bryant <raybry@sgi.com>
Cc: alexn@telia.com, linux-kernel@vger.kernel.org
Subject: Re: lockmeter in 2.6.9-rc2-mm2
Message-Id: <20040923212106.7a89b3af.akpm@osdl.org>
In-Reply-To: <41539FC1.7040001@sgi.com>
References: <41539FC1.7040001@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> wrote:
>
> This seems to compile for me, at least,

Great.

> haven't gotten to do a test of it.

Please do.

> Does the x86_64 stuff compile now?

yup.  I do regular x86 and x86_64 allfooconfig builds.  I'd do so on
sparc64/ppc64/ia64 too, if they had a chance of compiling :(

