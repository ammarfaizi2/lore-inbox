Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVDEGvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVDEGvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDEGvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:51:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:31918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261578AbVDEGvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:51:39 -0400
Date: Mon, 4 Apr 2005 23:51:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash during boot for 2.6.12-rc2.
Message-Id: <20050404235130.27e3437a.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0504042355440.9202-100000@thoron.boston.redhat.com>
References: <20050404194855.150b5363.akpm@osdl.org>
	<Xine.LNX.4.44.0504042355440.9202-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> n Mon, 4 Apr 2005, Andrew Morton wrote:
> 
>  > > I got this on a dual P4 Xeon with HT.  If anyone wants more information, 
>  > >  let me know.
>  > > 
>  > 
>  > .config, please..
> 
>  #
>  # Automatically generated make config: don't edit
>  # Linux kernel version: 2.6.12-rc2

Surprise, surprise, it works OK here.

What compiler version?
