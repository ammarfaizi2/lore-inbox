Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269663AbUINUxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269663AbUINUxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbUINUxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:53:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:36745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269757AbUINUw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:52:27 -0400
Date: Tue, 14 Sep 2004 13:47:29 -0700
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] missing pci_disable_device()
Message-ID: <20040914204729.GB22110@kroah.com>
References: <413D0E4E.1000200@jp.fujitsu.com> <1094550581.9150.8.camel@localhost.localdomain> <413E7925.1010801@jp.fujitsu.com> <1094647195.11723.5.camel@localhost.localdomain> <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com> <41403075.1010103@jp.fujitsu.com> <20040909173349.GA14633@kroah.com> <41451A26.40405@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41451A26.40405@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 12:55:18PM +0900, Kenji Kaneshige wrote:
> Here is an updated patch for missing pci_disable_device().
> Greg, please apply.

Applied, thanks.

greg k-h
