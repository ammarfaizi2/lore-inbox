Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267488AbUGWCIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbUGWCIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 22:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUGWCID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 22:08:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:31637 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267488AbUGWCH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 22:07:58 -0400
Date: Thu, 22 Jul 2004 22:07:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.8-rc1] Prevent excessive scanning of lower zone
Message-Id: <20040722220701.7de4c31f.akpm@osdl.org>
In-Reply-To: <20040723014052.69937.qmail@web12826.mail.yahoo.com>
References: <20040723014052.69937.qmail@web12826.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel <sgoel01@yahoo.com> wrote:
>
> I emailed this a few weeks back to the list but it
> seems to have gotten lost...

It came through.  I was unable to reproduce the disproportional scanning
rate on almost exactly the same setup, so I parked the problem for a while.

I do agree with the analysis though.  The problem _could_ occur.  I dunno
why it happens for you and not for me...

