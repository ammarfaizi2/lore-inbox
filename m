Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbTIAOUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 10:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTIAOUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 10:20:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30100 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262939AbTIAOUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 10:20:38 -0400
Date: Mon, 1 Sep 2003 07:11:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.22-pre1][NET] timer cleanups
Message-Id: <20030901071126.60b0dc78.davem@redhat.com>
In-Reply-To: <1062424850.4414.40.camel@lima.royalchallenge.com>
References: <1062258097.8532.26.camel@lima.royalchallenge.com>
	<20030830203311.0b8c0807.davem@redhat.com>
	<1062424850.4414.40.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Sep 2003 19:30:51 +0530
Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:

> >  And in the ip6_flowlabel.c case things are
> > as buggy as they were before.
> 
> Please find the updated patch below and let me know if it's ok.

Looks great, patch applied.
