Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbUCYRZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUCYRXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:23:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:63632 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263529AbUCYRUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:20:02 -0500
Date: Thu, 25 Mar 2004 09:20:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brandon Low <lostlogic@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2 still does not boot but it progress : seems to be
 console font related
Message-Id: <20040325092002.62edd8e7.akpm@osdl.org>
In-Reply-To: <20040325161739.GC999@lostlogicx.com>
References: <406172C9.8000706@free.fr>
	<20040324095236.68cb1deb.akpm@osdl.org>
	<20040325161739.GC999@lostlogicx.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Low <lostlogic@gentoo.org> wrote:
>
> I was having a similar problem, and with nothing else on the system
>  changed, applying the patch fixed it.  Was freezing at "freeing unused
>  kernel memory" without the patch.

Drat, thanks.
