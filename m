Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbTEXTKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 15:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTEXTKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 15:10:50 -0400
Received: from frontier.tky.hut.fi ([130.233.20.137]:43162 "EHLO
	frontier.tky.hut.fi") by vger.kernel.org with ESMTP id S263534AbTEXTJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 15:09:51 -0400
Date: Sat, 24 May 2003 22:20:40 +0300
From: Kari Kallioinen <karbas-lkml@frontier.tky.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Tigon3 auto-negotiation and force media
Message-ID: <20030524192040.GB25173@frontier.tky.hut.fi>
Reply-To: karbas-lkml@frontier.tky.hut.fi
References: <fa.jus6v70.biufpm@ifi.uio.no> <3ECE9C6C.70103@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECE9C6C.70103@myrealbox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 03:10:52PM -0700, walt wrote:
> BTW, how do can you tell that the media choice is wrong?  'ifconfig' doesn't
> give me that information.

I'm getting the information from dmesg:

tg3: eth0: Link is up at 100 Mbps, half duplex.


-- 
Kari Kallioinen 
