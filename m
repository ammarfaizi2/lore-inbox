Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264090AbUESHI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUESHI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUESHI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:08:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:38346 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264090AbUESHI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:08:58 -0400
Date: Tue, 18 May 2004 23:55:03 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       tziporet@mellanox.co.il
Subject: Re: [PATCH] Add InfiniBand HCA IDs to pci_ids.h
Message-ID: <20040519065503.GA16965@kroah.com>
References: <52r7tjug7y.fsf@topspin.com> <20040518154604.GA3033@infradead.org> <52d651nvvd.fsf@topspin.com> <20040518235403.GB11042@kroah.com> <52ad05mcu2.fsf@topspin.com> <20040519033119.GB7196@kroah.com> <52fz9xko95.fsf_-_@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fz9xko95.fsf_-_@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 09:57:26PM -0700, Roland Dreier wrote:
> Add InfiniBand HCA IDs to pci_ids.h.
> This will let me kill mthca_pci.h in the mthca driver.

Applied, thanks.

greg k-h
