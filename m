Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272636AbTG1Bv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbTG1Bus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 21:50:48 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:27402 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272636AbTG1Btq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 21:49:46 -0400
From: Marino Fernandez <mjferna@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0 wont let me unmount eth0 upon reboot [solved]
Date: Sun, 27 Jul 2003 21:04:58 -0500
User-Agent: KMail/1.5.2
References: <200307261951.40050.mjferna@yahoo.com>
In-Reply-To: <200307261951.40050.mjferna@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307272104.59166.mjferna@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 7:51 pm, Marino Fernandez wrote:
> I've trying the new kernel. Everything is OK, except that when I shut down
> my machine, I get this message:
>
> unmounting remote filesystems
> unregistering_netdevice: waiting for eth0 to become free. usage count = -4
>
I just compiled 2.6.0-test2 and that was it!

Thanks guys.

