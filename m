Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVHRSC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVHRSC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVHRSC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:02:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20875 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932292AbVHRSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:02:26 -0400
Date: Thu, 18 Aug 2005 13:25:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] (5/5) I2C updates for 2.4.32-pre3
Message-ID: <20050818162509.GB6262@dmt.cnet>
References: <20050814151320.76e906d5.khali@linux-fr.org> <20050814171716.099b8f55.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814171716.099b8f55.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 05:17:16PM +0200, Jean Delvare wrote:
> Five log messages lack their trailing new line in i2c-core.

Jean,

All of these seem to be cleanups/cosmetic enhancements rather than real 
bugfixes, except the ML address update.

As you know, we've been trying to reduce the scope of patch acceptance
in v2.4.x to strictly necessary changes. 

Do any of these fall into this criteria? 

Cheers.
