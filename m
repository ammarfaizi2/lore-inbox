Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbTHXKzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 06:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTHXKzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 06:55:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18624 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263416AbTHXKzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 06:55:07 -0400
Date: Sun, 24 Aug 2003 03:46:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test4][ATM][RESEND] fix ambassador.c
Message-Id: <20030824034637.522fdeb3.davem@redhat.com>
In-Reply-To: <1061629891.1121.7.camel@lima.royalchallenge.com>
References: <1061629891.1121.7.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2003 14:41:31 +0530
Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:

> This patch cleans up the code making use of sti/cli.

Please make sure to send this to the ATM maintainer.  He's very
responsible so I only take significant ATM patches that come through
him.
