Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUH0Svh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUH0Svh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUH0Svh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:51:37 -0400
Received: from ida.rowland.org ([192.131.102.52]:10756 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S267317AbUH0SvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:51:02 -0400
Date: Fri, 27 Aug 2004 14:51:01 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Summarizing the PWC driver questions/answers
In-Reply-To: <20040827162613.GB32244@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0408271442040.650-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Greg KH wrote:

> Q: Why did you remove the hook from the pwc driver?
> A: It was there for the explicit purpose to support a binary only
>    module.  That goes against the kernel's documented procedures, so I
>    had to take it out.

Can you say exactly where these procedures/policies are spelled out?

Alan Stern

