Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVBJTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVBJTjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVBJTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:39:45 -0500
Received: from poup.poupinou.org ([195.101.94.96]:10511 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S261596AbVBJTjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:39:39 -0500
Date: Thu, 10 Feb 2005 20:39:37 +0100
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050210193937.GH1145@poupinou.org>
References: <20050210161809.GK3493@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210161809.GK3493@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6+20040907i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 05:18:10PM +0100, Stelian Pop wrote:
> Hi,
> 
> +ACPI Sony Notebook Control Driver (SNC) Readme
> +----------------------------------------------
> +	Copyright (C) 2004 Stelian Pop <stelian@popies.net>
> +
> +This mini-driver drives the ACPI SNC device present in the 
> +ACPI BIOS of the Sony Vaio laptops.
> +
> +It gives access to some extra laptop functionalities. In 
> +its current form, the only thing this driver does is letting
> +the user set or query the screen brightness.

Does those laptops support acpi_video?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
