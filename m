Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWFRJKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWFRJKj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 05:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWFRJKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 05:10:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932176AbWFRJKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 05:10:39 -0400
Date: Sun, 18 Jun 2006 02:09:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: nickpiggin@yahoo.com.au, sam@vilain.net, vatsa@in.ibm.com, dev@openvz.org,
       mingo@elte.hu, pwil3058@bigpond.net.au, sekharan@us.ibm.com,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
Message-Id: <20060618020932.5947a7dc.akpm@osdl.org>
In-Reply-To: <1150616176.7985.50.camel@Homer.TheSimpsons.net>
References: <20060615134632.GA22033@in.ibm.com>
	<4493C1D1.4020801@yahoo.com.au>
	<20060617164812.GB4643@in.ibm.com>
	<4494DF50.2070509@yahoo.com.au>
	<4494EA66.8030305@vilain.net>
	<4494EE86.7090209@yahoo.com.au>
	<20060617234259.dc34a20c.akpm@osdl.org>
	<1150616176.7985.50.camel@Homer.TheSimpsons.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006 09:36:16 +0200
Mike Galbraith <efault@gmx.de> wrote:

> as
> evolution mail demonstrates to me every time it's GUI hangs and I see
> that a nice 19 find is running, eating very little CPU, but effectively
> DoSing evolution nonetheless (journal).

eh?  That would be an io scheduler bug, wouldn't it?

Tell us more.
