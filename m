Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWDSS5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWDSS5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWDSS5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:57:22 -0400
Received: from fmr17.intel.com ([134.134.136.16]:23236 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751067AbWDSS5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:57:21 -0400
Date: Wed, 19 Apr 2006 11:53:54 -0700
From: Patrick Mochel <mochel@linux.intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: PATCH [1/3]: Provide generic backlight support in Asus ACPI driver
Message-ID: <20060419185354.GC15072@linux.intel.com>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418161100.GA31763@linux.intel.com> <20060419184909.GB23513@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419184909.GB23513@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 07:49:09PM +0100, Matthew Garrett wrote:
> Here are some fixed-up versions of my patches to move acpi drivers 
> towards using the standard backlight interface. I've kept the dynamic 
> allocation of backlight_device for now, since changing that would also 
> mean changing the backlight core code and updating other drivers.

Nice, looks good to me. 

Thanks,


	Pat
