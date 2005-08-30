Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVH3UsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVH3UsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVH3UsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:48:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:60619 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932458AbVH3UsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:48:18 -0400
Message-ID: <4314C604.4030208@pobox.com>
Date: Tue, 30 Aug 2005 16:48:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13] Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com>
In-Reply-To: <20050830183625.BEE1520F4C@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> This is the first public release of my libata compatible low level driver for
> the Marvell SATA family.  Currently it successfully runs in PIO mode on a 6081
> chip.  EDMA support is in the works and should be done shortly.  Review,
> testing (especially on other flavors of Marvell), comments welcome.

Even though its only PIO, if you feel this is stable, I would like to 
get it into upstream soon-ish.

Current version looks OK to me.

	Jeff



