Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTIVJO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTIVJO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 05:14:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11468 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262443AbTIVJO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 05:14:59 -0400
Date: Mon, 22 Sep 2003 02:02:05 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: diadon@isfera.ru, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] fix ipt_REJECT when used in OUTPUT
Message-Id: <20030922020205.6b239e71.davem@redhat.com>
In-Reply-To: <20030922085326.GF31401@sunbeam.de.gnumonks.org>
References: <20030921144013.GA22223@sunbeam.de.gnumonks.org>
	<3F6EAFF2.9080303@isfera.ru>
	<20030922085326.GF31401@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Sep 2003 10:53:26 +0200
Harald Welte <laforge@netfilter.org> wrote:

> David, pleas defer applying that patch until further testing is done.
> 
> Sorry for the confusion.

Already pushed to Marcelo, just send me the fix I should apply
on top once you have this issue solved.
