Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTJHOzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTJHOzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:55:46 -0400
Received: from rth.ninka.net ([216.101.162.244]:60832 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261644AbTJHOzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:55:45 -0400
Date: Wed, 8 Oct 2003 07:54:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: ookhoi@humilis.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: why does netfilter make upload very slow? (was: Re: e1000 ->
 82540EM on linux 2.6.0-test[45] very slow in one direction)
Message-Id: <20031008075441.4c6820b7.davem@redhat.com>
In-Reply-To: <20031008131320.GD16964@favonius>
References: <20031008131320.GD16964@favonius>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003 15:13:20 +0200
ookhoi@humilis.net wrote:

> Would somebody like to explain why netfilter (in kernel, but not in use)
> makes upload go very slow? I am by no means a network guru, but eager to
> learn :-)

It'll likely happen much quicker if you actually report this to
the netfilter lists, which is where the people who can help you
are paying attention.
