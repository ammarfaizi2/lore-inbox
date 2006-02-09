Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWBIFqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWBIFqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422803AbWBIFqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:46:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:6317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422802AbWBIFqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:46:39 -0500
Date: Wed, 8 Feb 2006 21:46:03 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060209054603.GB18324@kroah.com>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org> <20060208171649.GA21373@kroah.com> <20060208174933.GA30719@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208174933.GA30719@srcf.ucam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 05:49:33PM +0000, Matthew Garrett wrote:
> +/**
> + *	pm_set_ac_status - Set the ac status callback.
> + *	@ops:	Pointer to function
> + *
> + *      Provide a callback that returns true if the system is currently on
> + *      AC power. This should be called by power management subsystems.
> + */

Mix of tabs and spaces here.  Just use 1 space after the "*" character.

thanks,

greg k-h
