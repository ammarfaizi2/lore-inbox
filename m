Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUFNR6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUFNR6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUFNR6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:58:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:13522 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263687AbUFNR6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:58:32 -0400
Date: Mon, 14 Jun 2004 10:57:23 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Fix off-by-one in pci_enable_wake
Message-ID: <20040614175723.GB27216@kroah.com>
References: <20040614172225.GA23014@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614172225.GA23014@k3.hellgate.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 07:22:25PM +0200, Roger Luethi wrote:
> Fix off-by-one in pci_enable_wake.
> Bit field location determined by mask, not value.

Applied, thanks.

greg k-h
