Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTIDOEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbTIDOEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:04:34 -0400
Received: from www.mail15.com ([194.186.131.96]:18444 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S265030AbTIDOEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:04:32 -0400
Message-ID: <3F57462C.9030107@hotmail.com>
Date: Thu, 04 Sep 2003 07:03:24 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5b) Gecko/20030830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tg3/Broadcom gigabit driver just got worse in 2.4.23-pre3
References: <3F569AF8.9040507@myrealbox.com> <3F573529.8060906@pobox.com>
In-Reply-To: <3F573529.8060906@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Does 2.4.23-pre2 work for you?
> 

Yes, as long as I do the one-time ifconfig down/up cycle
after each reboot -- the same as it's been since 2.4.-21-pre5.

The really bad stuff was just introduced yesterday in 23-pre3.

