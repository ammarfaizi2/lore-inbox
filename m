Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbTCQSsG>; Mon, 17 Mar 2003 13:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbTCQSsF>; Mon, 17 Mar 2003 13:48:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:32224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261776AbTCQSsF>;
	Mon, 17 Mar 2003 13:48:05 -0500
Date: Mon, 17 Mar 2003 10:55:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modutils for 2.5
Message-Id: <20030317105550.6786d3b5.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.51.0303171939040.15852@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0303171931220.29964@dns.toxicfilms.tv>
	<Pine.LNX.4.51.0303171939040.15852@dns.toxicfilms.tv>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 19:39:20 +0100 (CET) Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

| Hi,
| 
| is there a special modutils package needed for 2.5 kernels?
| 
| lsmod on 2.5 says QM_MODULES not supported, and while
| 
| # make modules_install
| i always get tons of unresolved symbols about all what is in the modules.
| 
| I tried modutils 2.4.21 and 2.4.23 with the same result

Yes, please read this for general 2.5 changes:
  http://www.codemonkey.org.uk/post-halloween-2.5.txt
and get 2.5 module tools from here:
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

--
~Randy
