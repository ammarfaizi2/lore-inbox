Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVJBTys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVJBTys (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 15:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVJBTys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 15:54:48 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:19212 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751056AbVJBTyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 15:54:47 -0400
Date: Sun, 2 Oct 2005 15:13:59 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: 7eggert@gmx.de, Ed Tomlinson <tomlins@cam.org>,
       lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051002191359.GA26847@ccure.user-mode-linux.org>
References: <4SXfo-7hM-9@gated-at.bofh.it> <4T47e-5E-1@gated-at.bofh.it> <4TbLq-2VG-5@gated-at.bofh.it> <4TcR9-4sS-9@gated-at.bofh.it> <E1EM7KO-00014G-CK@be1.lrz> <20051002175116.GE5211@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002175116.GE5211@blackham.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 01:51:16AM +0800, Bernard Blackham wrote:
> Interesting idea though - it'd be somewhat akin to porting
> suspend-to-disk to UML (which has been on suspend2's todo list for a
> while though :)

It would be exactly that.  Note that external network connections are still
going to cause problems.

				Jeff
