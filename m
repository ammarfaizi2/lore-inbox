Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUK0DpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUK0DpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUK0Dof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:44:35 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262676AbUKZTfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:48 -0500
Subject: Re: tcp port reuse checking TCP_LISTEN state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <fcb9aa29041123022027c1ec06@mail.gmail.com>
References: <fcb9aa29041123022027c1ec06@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101398703.18177.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 16:05:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-23 at 10:20, Ilya Pashkovsky wrote:
> Hello, fellow developers.
> 
> While BSD (and thus, MacOS X) has the SO_REUSEPORT socket option, and
> Windows has SO_REUSEADDR socket option that integrates the port reuse
> functionality, linux tends to differ.

You should probably ask netdev@oss.sgi.com as that is where most
networking developers hang out

