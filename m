Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbTIWT5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTIWT5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:57:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6877 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261653AbTIWT5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:57:01 -0400
Date: Tue, 23 Sep 2003 12:43:48 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: diadon@isfera.ru, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] fix ipt_REJECT when used in OUTPUT
Message-Id: <20030923124348.682fdf6a.davem@redhat.com>
In-Reply-To: <20030922122159.GK31401@sunbeam.de.gnumonks.org>
References: <20030922085326.GF31401@sunbeam.de.gnumonks.org>
	<20030922020205.6b239e71.davem@redhat.com>
	<20030922122159.GK31401@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Sep 2003 14:21:59 +0200
Harald Welte <laforge@netfilter.org> wrote:

> On Mon, Sep 22, 2003 at 02:02:05AM -0700, David S. Miller wrote:
>  
> > Already pushed to Marcelo, just send me the fix I should apply
> > on top once you have this issue solved.
> 
> Ok, here goes the (confirmed to be working) fix. TIA.

Applied, thanks.
