Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVBWXYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVBWXYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVBWXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:24:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:52440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261689AbVBWXU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:20:29 -0500
Date: Wed, 23 Feb 2005 15:25:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
Message-Id: <20050223152523.552f910a.akpm@osdl.org>
In-Reply-To: <200502231807.52877.tomlins@cam.org>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<200502231807.52877.tomlins@cam.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> It does not seem to be finding the keyboard at all...

Can you confirm that Linus's tree is OK?  You'd best use the patch
at http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ to make sure you
have the latest stuff.
