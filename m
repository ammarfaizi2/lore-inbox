Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbTL3RlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 12:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbTL3RlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 12:41:00 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:40556 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265870AbTL3Rk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 12:40:59 -0500
Message-ID: <3FF1B8DD.2000209@hotmail.com>
Date: Tue, 30 Dec 2003 09:41:49 -0800
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] 2.6.x experimental net driver updates
References: <fa.e1afrvu.1ek2sq2@ifi.uio.no>
In-Reply-To: <fa.e1afrvu.1ek2sq2@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Summary of patchkit:
> 
> * tg3 bug fixes

Hi Jeff,

I applied the tg3 portion of these patches.  Unfortunately it doesn't fix
the one persistent bug which AFAIK affects only me in the entire world. :-(

I'm the one with the ASUS A7V8X with builtin Broadcom Corporation NetXtreme
BCM5702 Gigabit Ethernet(rev 02) that doesn't initialize quite right.

Even with this new patch I have to do an ifconfig down/up before the chip
starts to function.  <sigh>

