Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbUCUNOU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 08:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbUCUNOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 08:14:19 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:20241 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263648AbUCUNOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 08:14:18 -0500
Date: Sun, 21 Mar 2004 13:14:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, gerg@snapgear.com, greg@kroah.com
Subject: Re: [PATCH 2.6 stallion.c] RFT added class support to stallion.c
Message-ID: <20040321131410.A7758@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	gerg@snapgear.com, greg@kroah.com
References: <68680000.1079748527@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <68680000.1079748527@w-hlinder.beaverton.ibm.com>; from hannal@us.ibm.com on Fri, Mar 19, 2004 at 06:08:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 06:08:47PM -0800, Hanna Linder wrote:
> 
> Here is a patch to add class support to the Stallion multiport 
> serial driver.
> 
> I have verified it compiles but do not have the hardware. 
> If you can please verify, thanks.
> 
> Please consider for Inclusion or Testing.

Shouldn't this be covered by the tty subsystem?

