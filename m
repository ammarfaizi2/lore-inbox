Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTJ1SGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbTJ1SGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:06:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17351 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264061AbTJ1SGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:06:20 -0500
Date: Tue, 28 Oct 2003 09:57:47 -0800
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.or
Subject: Re: status of ipchains in 2.6?
Message-Id: <20031028095747.2cdb57e7.davem@redhat.com>
In-Reply-To: <16286.44522.275791.73904@napali.hpl.hp.com>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
	<20031028015032.734caf21.davem@redhat.com>
	<16286.44522.275791.73904@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 09:56:58 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On Tue, 28 Oct 2003 01:50:32 -0800, "David S. Miller" <davem@redhat.com> said:
> 
> $ fgrep -i ipchain MAINTAINERS

Try netfilter, ipchains is a part of netfilter.
