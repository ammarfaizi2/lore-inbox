Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUFQUPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUFQUPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUFQUPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:15:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35233 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262398AbUFQUPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:15:11 -0400
Subject: Re: [PATCH] remove EXPORT_SYMBOL(kallsyms_lookup)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200406171731.i5HHVA0M015051@car.linuxhacker.ru>
References: <20040617162927.GA12498@kroah.com>
	 <200406171731.i5HHVA0M015051@car.linuxhacker.ru>
Content-Type: text/plain
Message-Id: <1087503272.29041.34.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 17 Jun 2004 15:14:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 12:31, Oleg Drokin wrote:

> Or perhaps we need dump_stack version that will print the dump into a
> supplied buffer then?

That would make it easy to implement /proc/<num>/stack.  I think that
would be useful.
-- 
David Kleikamp
IBM Linux Technology Center

