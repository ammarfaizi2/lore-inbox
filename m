Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVCOExZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVCOExZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVCOExZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:53:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:39865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262248AbVCOExQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:53:16 -0500
Date: Mon, 14 Mar 2005 20:52:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, roland@redhat.com, sivanich@sgi.com
Subject: Re: Exports to enable clock driver modules
Message-Id: <20050314205254.5c382dcd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503142034190.16107@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503142034190.16107@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> The following exports are necessary to allow loadable modules to define
>  new clocks.

I'll convert these to EXPORT_SYMBOL_GPL, OK?
