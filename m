Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVFDWxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFDWxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 18:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFDWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 18:53:34 -0400
Received: from pop.gmx.net ([213.165.64.20]:57512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261433AbVFDWxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 18:53:33 -0400
X-Authenticated: #271361
Date: Sun, 5 Jun 2005 00:53:29 +0200
From: Edgar Toernig <froese@gmx.de>
To: Henk <Henk.Vergonet@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-Id: <20050605005329.70d9461a.froese@gmx.de>
In-Reply-To: <20050604204403.GA10417@god.dyndns.org>
References: <20050531220738.GA21775@god.dyndns.org>
	<429DAB07.1050900@anagramm.de>
	<20050604204403.GA10417@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henk wrote:
>
> Pavel wrote:
> > Keep 7-segment displays out of kernel. If it is usb, drive it from
> > userspace with libusb...
> 
> I see that you did not provide any arguments.

The kernel already provides a method to store arbitrary tables - the
filesystem.  By your reasoning /usr/dict/words had to be in the kernel,
too.

Ciao, ET.
