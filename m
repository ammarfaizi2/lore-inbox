Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUAYTek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUAYTek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:34:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47554 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265231AbUAYTei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:34:38 -0500
Date: Sun, 25 Jan 2004 11:25:42 -0800 (PST)
Message-Id: <20040125.112542.10303353.davem@redhat.com>
To: sebek64@post.cz
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kaber@trash.net
Subject: Re: [RFC/PATCH] IMQ port to 2.6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040125152419.GA3208@penguin.localdomain>
References: <20040125152419.GA3208@penguin.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: sebek64@post.cz (Marcel Sebek)
   Date: Sun, 25 Jan 2004 16:24:19 +0100

   I have ported IMQ driver from 2.4 to 2.6.2-rc1.
   
   Original version was from http://trash.net/~kaber/imq/.
   
Patrick, do you mind if I merge this 2.6.x port into my tree?
