Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVKNRTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVKNRTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVKNRTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:19:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:23530 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751201AbVKNRTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:19:14 -0500
Date: Mon, 14 Nov 2005 09:05:14 -0800
From: Greg KH <gregkh@suse.de>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Linda Xie <lxie@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       John Rose <johnrose@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051114170514.GA18741@suse.de>
References: <20051110130626.GA7966@sergelap.austin.ibm.com> <OFE00FE25C.725B5669-ON872570B5.0066EFF0-862570B5.00679646@us.ibm.com> <20051111175904.GA21272@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111175904.GA21272@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 11:59:04AM -0600, Serge Hallyn wrote:
> Quoting Linda Xie (lxie@us.ibm.com):
> > Hi Andrew,
> > 
> > It seems that the latest mm1 doesn't have  the following patch that John 
> > Rose sent on last Friday.
> 
> One more thing seems to be missing.  -mm2 compiles and boots if
> i add:
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

John and Linda, is this patch correct?

thanks,

greg k-h
