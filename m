Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266700AbUBMD2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266709AbUBMD2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:28:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28570 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266700AbUBMD2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:28:52 -0500
Date: Thu, 12 Feb 2004 19:28:09 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ping Cheng <pingc@wacom.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Wacom USB driver patch
Message-Id: <20040212192809.3c7e6db4.zaitcev@redhat.com>
In-Reply-To: <28E6D16EC4CCD71196610060CF213AEB065BCA@wacom-nt2.wacom.com>
References: <28E6D16EC4CCD71196610060CF213AEB065BCA@wacom-nt2.wacom.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004 16:55:47 -0800
Ping Cheng <pingc@wacom.com> wrote:

> The wacom.c at http://linux.bkbits.net:8080/linux-2.4 is way out of date and
> people are still working on/using 2.4 releases. Should I make a patch for
> 2.4?

We plan to support 2.4 based releases for several years yet. If Vojtech
approves what you did for 2.6, I am all for a backport to Marcelo tree.
Marcelo is not very forthcoming with approvals these days, but perhaps
it may be folded into some update. But as usual I would like to avoid
carrying a patch in Red Hat tree, if at all possible.

-- Pete
