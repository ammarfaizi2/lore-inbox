Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVALXe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVALXe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVALX3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:29:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:51343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261593AbVALX3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:29:17 -0500
Date: Wed, 12 Jan 2005 15:28:02 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement --updated version
Message-ID: <20050112232801.GA15332@kroah.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com> <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com> <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:45:23PM -0600, Kylene Hall wrote:
> This patch is a device driver to enable new hardware.  The new hardware is
> the TPM chip as described by specifications at 
> <http://www.trustedcomputinggroup.org>.  The TPM chip will enable you to
> use hardware to securely store and protect your keys and personal data.
> To use the chip according to the specification, you will need the Trusted
> Software Stack (TSS) of which an implementation for Linux is available at:
> <http://sourceforge.net/projects/trousers>.

I've added this to my bk trees, and it should show up in the next -mm
release.  Lets see how that works out.

thanks,

greg k-h
