Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752289AbWCNFbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbWCNFbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbWCNFbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:31:31 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:6591 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1752289AbWCNFba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:31:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 6/9] i8042: adjust pnp_register_driver signature
Date: Tue, 14 Mar 2006 00:31:27 -0500
User-Agent: KMail/1.9.1
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-input@atrey.karlin.mff.cuni.cz
References: <200603021601.27467.bjorn.helgaas@hp.com> <200603021609.42272.bjorn.helgaas@hp.com>
In-Reply-To: <200603021609.42272.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140031.28375.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 18:09, Bjorn Helgaas wrote:
> Remove the assumption that pnp_register_driver() returns the number of
> devices claimed.
>

Applied, thank you Bjorn.

-- 
Dmitry
