Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVGFT2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVGFT2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGFT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:28:23 -0400
Received: from isilmar.linta.de ([213.239.214.66]:55225 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262287AbVGFOG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:06:59 -0400
Date: Wed, 6 Jul 2005 16:06:53 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: st3@riseup.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedstep-centrino on dothan
Message-ID: <20050706140653.GA6415@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	st3@riseup.net, linux-kernel@vger.kernel.org
References: <20050706112202.33d63d4d@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706112202.33d63d4d@horst.morte.male>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 06, 2005 at 11:22:02AM +0200, st3@riseup.net wrote:
> Currently, the speedstep-centrino support has built-in frequency/voltage
> pairs only for Banias CPUs. For Dothan CPUs, these tables are read from
> BIOS ACPI.
> 
> But ACPI encoding may not be available or not reliable, so why shouldn't we
> provide built-in tables for Dothan CPUs, too? Intel has released this
> datasheet:
> 
> http://www.intel.com/design/mobile/datashts/302189.htm
> 
> with frequency/voltage pairs for every version of Dothan CPUs.

However, it is not known which one of VID#A, VID#B, VID#C or VID#D is to be
used on a specific system.

	Dominik
