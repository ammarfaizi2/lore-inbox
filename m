Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVKOJEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVKOJEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVKOJEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:04:32 -0500
Received: from barclay.balt.net ([195.14.162.78]:45880 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S1751393AbVKOJEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:04:30 -0500
Subject: Re: Linuv 2.6.15-rc1
From: =?iso-8859-2?Q?=AEilvinas?= Valinskas <zilvinas@gemtek.lt>
Reply-To: zilvinas@gemtek.lt
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43790F00.2020401@tmr.com>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <4378980C.7060901@ens-lyon.fr> <20051114143248.GA3859@gemtek.lt>
	 <43790F00.2020401@tmr.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 11:04:16 +0200
Message-Id: <1132045456.6823.1.camel@swoop.gemtek.lt>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 17:26 -0500, Bill Davidsen wrote:
> You are running the correct firmware? I don't have my system handy, but 
> the Intel page says 2.4 firmware with the driver.

$ ls  /lib/firmware/ipw-2.4-*
/lib/firmware/ipw-2.4-boot.fw       /lib/firmware/ipw-2.4-ibss_ucode.fw
/lib/firmware/ipw-2.4-bss.fw        /lib/firmware/ipw-2.4-sniffer.fw
/lib/firmware/ipw-2.4-bss_ucode.fw  /lib/firmware/ipw-2.4-sniffer_ucode.fw
/lib/firmware/ipw-2.4-ibss.fw



