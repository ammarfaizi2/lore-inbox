Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbTEWTwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbTEWTwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 15:52:23 -0400
Received: from frontier.tky.hut.fi ([130.233.20.137]:65416 "EHLO
	frontier.tky.hut.fi") by vger.kernel.org with ESMTP id S264161AbTEWTwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 15:52:22 -0400
Date: Fri, 23 May 2003 23:03:14 +0300
From: Kari Kallioinen <karbas-lkml@frontier.tky.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Tigon3 auto-negotiation and force media
Message-ID: <20030523200314.GA25173@frontier.tky.hut.fi>
Reply-To: karbas-lkml@frontier.tky.hut.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with broadcomm 5700 based card.
It's autonegotiating a wrong media and I can't change the parameters of another
end of link. So how I can force specified media technology with tg3-driver?
Mii-tool doesn't seem to work and I didn't find any option for tg3-module.

I have version 1.5 of tg3.c and Linux version 2.4.21-rc2.

-- 
Kari Kallioinen
