Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUA3JyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 04:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUA3JyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 04:54:09 -0500
Received: from mail.gmx.de ([213.165.64.20]:59293 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261492AbUA3JyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 04:54:07 -0500
X-Authenticated: #222435
Date: Fri, 30 Jan 2004 10:54:30 +0100
From: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which interface: sysfs, proc, devfs?
Message-Id: <20040130105430.1e6ada9a.diemer@gmx.de>
In-Reply-To: <20040129230250.GA9988@kroah.com>
References: <20040129222813.3b22b2c8.diemer@gmx.de>
	<20040129230250.GA9988@kroah.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 15:02:50 -0800
Greg KH <greg@kroah.com> wrote:

> What about not writing a kernel driver at all and just using
> libusb/usbfs?  Any reason you have to have a kernel driver for your
> device?

Well, didn't think about that, but it indeed seems more logical. Thanks
for the hint.

regards
Jonas

PS: CC me in replies, please
