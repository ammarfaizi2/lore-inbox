Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVCCA2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVCCA2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVCCATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:19:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:33178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261415AbVCCAPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:15:10 -0500
Date: Wed, 2 Mar 2005 16:14:49 -0800
From: Greg KH <greg@kroah.com>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH 2.6] Trivial indentation fix in i2c/chips/Kconfig
Message-ID: <20050303001449.GB10340@kroah.com>
References: <4224C0D4.2060303@katalix.com> <cIyC5ZN2.1109756623.5808030.khali@localhost> <20050302194522.2512fe02.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302194522.2512fe02.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 07:45:22PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Quoting myself:
> 
> > (...) I also think I see an indentation issue on the "tristate" line,
> > seemingly copied from the SENSORS_DS1621 section which would need to
> > be fixed as well.
> 
> Here is the trivial patch fixing that, if you want to apply it.
> 
> Thanks,
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
