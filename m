Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWDRJ0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDRJ0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDRJ0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:26:06 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:54691 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750724AbWDRJ0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:26:05 -0400
Date: Tue, 18 Apr 2006 10:26:01 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: PATCH [2/3]: Provide generic backlight support in IBM ACPI driver
Message-ID: <20060418092601.GA14121@srcf.ucam.org>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418083056.GA13846@srcf.ucam.org> <20060418091857.GB30628@osgiliath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418091857.GB30628@osgiliath>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 11:18:57AM +0200, Henrik Brix Andersen wrote:

> Wouldn't it be better to have ACPI_IBM and friends select
> BACKLIGHT_DEVICE?

Hmm. Probably, yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
