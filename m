Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVGGVnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVGGVnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGGVlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:41:01 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:55747 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261916AbVGGVib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:38:31 -0400
Message-ID: <42CDA0D1.7050209@snacksy.com>
Date: Thu, 07 Jul 2005 23:38:25 +0200
From: jan malstrom <xanon@snacksy.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipw2100 doesnt compile:

net/built-in.o(.text+0x921fc): In function `ieee80211_xmit':
: undefined reference to `is_broadcast_ether_addr'


jan
