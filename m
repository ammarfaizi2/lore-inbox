Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTEZEGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTEZEGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:06:39 -0400
Received: from rth.ninka.net ([216.101.162.244]:48515 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264235AbTEZEGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:06:38 -0400
Subject: Re: Tigon3 auto-negotiation and force media
From: "David S. Miller" <davem@redhat.com>
To: karbas-lkml@frontier.tky.hut.fi
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030523200314.GA25173@frontier.tky.hut.fi>
References: <20030523200314.GA25173@frontier.tky.hut.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053922725.14018.9.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 May 2003 21:18:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-23 at 13:03, Kari Kallioinen wrote:
> So how I can force specified media technology with tg3-driver?

Just like for any other ethernet driver, you use the
'ethtool' utility to do this.

-- 
David S. Miller <davem@redhat.com>
