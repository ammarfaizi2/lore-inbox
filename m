Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbUKYBEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbUKYBEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbUKYBEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:04:39 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:18907 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S262872AbUKYBEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:04:36 -0500
Date: Wed, 24 Nov 2004 15:26:59 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ub: oops with preempt ("Sahara Workshop")
Message-ID: <20041124232659.GI4394@kroah.com>
References: <20041123100247.2ea47e2d@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123100247.2ea47e2d@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 10:02:47AM -0800, Pete Zaitcev wrote:
> I admit that the code should be locked properly instead, but the global plan
> is to drop all P3 tagged printks anyway. So let it be guarded for the moment.
> 
> Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>

Applied, thanks.

greg k-h

