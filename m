Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266601AbUAOI4m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 03:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266602AbUAOI4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 03:56:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58074 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266601AbUAOI4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 03:56:41 -0500
Date: Thu, 15 Jan 2004 00:49:29 -0800
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.X] SIOCSIFNAME wilcard suppor & name validation
Message-Id: <20040115004929.4b76ede2.davem@redhat.com>
In-Reply-To: <20040114161324.61b7198f.shemminger@osdl.org>
References: <20040112234332.GA1785@bougret.hpl.hp.com>
	<20040113142204.0b41403b.shemminger@osdl.org>
	<20040113162112.509edb71.davem@redhat.com>
	<20040114161324.61b7198f.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 16:13:24 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> Bug: dev_alloc_name returns the number of the slot used, so comparison needs
> to be < 0.

Applied, thanks Stephen.
