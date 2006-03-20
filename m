Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWCTUW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWCTUW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWCTUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:22:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:2737 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030218AbWCTUWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:22:25 -0500
Date: Mon, 20 Mar 2006 20:22:24 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Merge strategy for klibc
Message-ID: <20060320202224.GE27946@ftp.linux.org.uk>
References: <441F0859.2010703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441F0859.2010703@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 11:54:01AM -0800, H. Peter Anvin wrote:
> Okay, as of this point, I think klibc is in quite good shape; my
> testing so far is showing that it can be used as a drop-in replacement
> for the kernel root-mounting code.
> 
> That being said, there is guaranteed to be breakage, for two reasons:
> 
> a. There are several architectures which don't have klibc ports yet.
>    Since I don't have access to them, I can't really do them, either.
>    It's usually a matter of an afternoon or less to port klibc to a
>    new architecture, though, if you have a working development
>    environment for it.

Which ones?
