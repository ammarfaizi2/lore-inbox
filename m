Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUKDUPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUKDUPC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUKDUML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:12:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:3211 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262389AbUKDUIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:08:45 -0500
Date: Thu, 4 Nov 2004 12:07:37 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, azarah@nosferatu.za.org
Subject: Re: Patch for ub in 2.6.10-rc1
Message-ID: <20041104200737.GC21149@kroah.com>
References: <20041104000840.56412e6f@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104000840.56412e6f@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:08:40AM -0800, Pete Zaitcev wrote:
> This is a relatively small changeset, to address small nagging problems.
> Andrew pointed me at the double registration specifically, so I had to do
> something about it. At least now Fabio's box won't collapse if he configures
> UB by mistake. Also, a few people complained that the help text was
> misleading.

Applied, thanks.

greg k-h
