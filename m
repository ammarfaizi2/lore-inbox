Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUGBWaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUGBWaE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUGBWaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:30:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:17058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264998AbUGBWaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:30:01 -0400
Date: Fri, 2 Jul 2004 15:32:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, Yichen Xie <yxie@cs.stanford.edu>
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
Message-Id: <20040702153250.5aa68e48.akpm@osdl.org>
In-Reply-To: <pan.2004.07.02.10.00.00.617324@smurf.noris.de>
References: <Pine.LNX.4.44.0407011747040.4015-100000@kaki.stanford.edu>
	<20040701213837.0b97c21e.akpm@osdl.org>
	<pan.2004.07.02.10.00.00.617324@smurf.noris.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> wrote:
>
> Hi, Andrew Morton wrote:
> 
> > If someone wants to volunteer to maintain this list, that would be nice.
> 
> I can do that.
> 

Thanks.  But if Yichen is able to perform regular (say, weekly) runs of the
tool against the latest kernel tree there shouldn't be a need for this.  I
expect the list will shrink fairly quickly at least initially.


