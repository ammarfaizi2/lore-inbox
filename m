Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272585AbTHBBTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 21:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272586AbTHBBTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 21:19:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:38287 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272585AbTHBBTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 21:19:47 -0400
Date: Fri, 1 Aug 2003 18:19:43 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com, andrea@suse.de,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-ID: <20030802011943.GA1107@kroah.com>
References: <20030801160036.029e542b.akpm@osdl.org> <20030802003246.064132C04F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802003246.064132C04F@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 10:32:24AM +1000, Rusty Russell wrote:
> Just please please please don't break any API in a stable series.

We reserve the right to break any in-kernel api if it is deemed
necessary, this is Linux after all :)

thanks,

greg k-h
