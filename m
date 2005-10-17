Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVJQR6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVJQR6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVJQR6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:58:36 -0400
Received: from mail.cs.umn.edu ([128.101.32.202]:13004 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1751234AbVJQR6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:58:35 -0400
Date: Mon, 17 Oct 2005 12:58:29 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: linux-scsi@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ibmvscsis scsi target
Message-ID: <20051017175829.GA12958@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20051017143644.GA9992@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017143644.GA9992@cs.umn.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 09:36:44AM -0500, Dave Boutcher wrote:
> Here's the ibmvscsis SCSI target submitted for inclusion in 2.4.15.
> This driver meets a couple of akpm's criteria for worthiness, in that
> its actually been shipping for a while in a distro kernel, and (given
> the posts when I broke compatibility) is being used.

BTW, s/2.4.15/2.6.15/.  Living in the past again...

-- 
Dave Boutcher
