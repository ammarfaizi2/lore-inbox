Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWHBKjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWHBKjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 06:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWHBKjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 06:39:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30479 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750735AbWHBKjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 06:39:44 -0400
Date: Wed, 2 Aug 2006 10:39:28 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matt Domsch <Matt_Domsch@dell.com>, "Brown, Len" <len.brown@intel.com>,
       Henrique de Moraes Holschuh <hmh@debian.org>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Message-ID: <20060802103927.GI7601@ucw.cz>
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This teachs dmi_decode() how to to save OEM Strings 
> (type 11) information.
> OEM Strings are  the only safe way to identify some 
> hardware, e.g., the ThinkPad
> embedded controller used by the soon-to-be-submitted 
> tp_smapi driver.
> 
> Follows the "System Management BIOS (SMBIOS) 
> Specification"
> (http://www.dmtf.org/standards/smbios), and also the 
> userspace
> dmidecode.c code.

Looks good to me.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
