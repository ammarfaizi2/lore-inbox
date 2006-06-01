Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWFAOJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWFAOJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWFAOJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:09:43 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:27274 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750960AbWFAOJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:09:42 -0400
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.17-rc5
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, torvalds@osdl.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060531222410.08dd6728.akpm@osdl.org>
References: <1149092818.22134.45.camel@mulgrave.il.steeleye.com>
	 <Pine.LNX.4.63.0606010757400.4387@kai.makisara.local>
	 <20060531222410.08dd6728.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 09:09:23 -0500
Message-Id: <1149170964.3489.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 22:24 -0700, Andrew Morton wrote:
> argh, that was me "improving" things.

That'll teach me to take your patches without checking them ...

I reversed this from the scsi-rc-fixes tree ... I'll reapply the correct
version.

James


