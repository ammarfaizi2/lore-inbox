Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWDSUZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWDSUZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWDSUZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:25:07 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:30162 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751242AbWDSUZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:25:05 -0400
Date: Wed, 19 Apr 2006 21:25:00 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Patrick Mochel <mochel@linux.intel.com>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: PATCH [1/3]: Provide generic backlight support in Asus ACPI driver
Message-ID: <20060419202500.GB24318@srcf.ucam.org>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418161100.GA31763@linux.intel.com> <20060419184909.GB23513@srcf.ucam.org> <20060419201323.GA26861@osgiliath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419201323.GA26861@osgiliath>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:13:23PM +0200, Henrik Brix Andersen wrote:

> Great stuff, I very much welcome these patches. Any plans for doing
> the same for the sony_acpi.c driver found in -mm?

I have a half-finished one lying around - I'll check it against the -mm 
code at some stage.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
