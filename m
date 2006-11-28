Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965914AbWK1U0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965914AbWK1U0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965978AbWK1U0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:26:34 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:50183 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S965914AbWK1U0d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:26:33 -0500
Date: Tue, 28 Nov 2006 21:26:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, i2c@lm-sensors.org
Subject: Re: [PATCH 2.6.19-rc6] i2c-i801: Documentation patch for Intel
 ICH9/ICH8/ESB2
Message-Id: <20061128212637.d541674a.khali@linux-fr.org>
In-Reply-To: <200611271053.11904.jason.d.gaston@intel.com>
References: <200611271053.11904.jason.d.gaston@intel.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 10:53:11 -0800, Jason Gaston wrote:
> This patch adds the Intel ICH9/ICH8/ESB2 SMBus Controller text to i2c-i801 documentation.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.19-rc6/Documentation/i2c/busses/i2c-i801.orig	2006-11-27 10:36:37.000000000 -0800
> +++ linux-2.6.19-rc6/Documentation/i2c/busses/i2c-i801	2006-11-27 10:43:02.000000000 -0800
> @@ -9,7 +9,10 @@
>    * Intel 82801EB/ER (ICH5) (HW PEC supported, 32 byte buffer not supported)
>    * Intel 6300ESB
>    * Intel 82801FB/FR/FW/FRW (ICH6)
> -  * Intel ICH7
> +  * Intel 82801G (ICH7)
> +  * Intel 631xESB/632xESB (ESB2)
> +  * Intel 82801H (ICH8)
> +  * Intel ICH9
>      Datasheets: Publicly available at the Intel website
>  
>  Authors: 

Applied, thanks.

-- 
Jean Delvare
