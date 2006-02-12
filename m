Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWBLKaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWBLKaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBLKaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:30:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932376AbWBLKaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:30:13 -0500
Date: Sun, 12 Feb 2006 02:29:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: kkeil@suse.de, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de, tilman@imap.cc
Subject: Re: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN
 DECT PABX
Message-Id: <20060212022921.664a0191.akpm@osdl.org>
In-Reply-To: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hansjoerg Lipp <hjlipp@web.de> wrote:
>
> The patch has been split into 9 parts to comply to size limits.
>  All of the parts are designed to be applied together.

This means that the patches should go into git in a single commit, so that
we don't have a non-compiling tree at any step.   That's not a problem.
