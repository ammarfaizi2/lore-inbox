Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030771AbWJKDQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030771AbWJKDQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030767AbWJKDQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:16:49 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:32195 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030766AbWJKDQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:16:48 -0400
Date: Wed, 11 Oct 2006 04:16:43 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061011031643.GA4010@srcf.ucam.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com> <200610102232.46627.luming.yu@gmail.com> <20061010212615.GB31972@srcf.ucam.org> <20061011030232.GA27693@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011030232.GA27693@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 10:02:32PM -0500, Matt Domsch wrote:

> Yes, our BIOS teams are looking to do exactly that.  I wouldn't expect
> such a change to be propogated back to earlier released systems though.

That's great news. I accept that it's impractical to port back to 
earlier hardware, but it means it'll stop being a problem eventually.

(Entirely unrelatedly, have you got any idea why several D-series 
Latitudes with Intel graphics switch off the backlight on lid close and 
never switch it back on again? It happens under Windows if you boot in 
safe mode, so it's not Linux specific...)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
