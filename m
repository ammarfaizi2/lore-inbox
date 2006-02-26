Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWBZOrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWBZOrd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWBZOrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:47:33 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:30675 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751144AbWBZOrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:47:32 -0500
Date: Sun, 26 Feb 2006 15:44:24 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: John Zielinski <john_ml@undead.cc>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: RTL 8139 stops RX after receiving a jumbo frame
Message-ID: <20060226144424.GA26879@electric-eye.fr.zoreil.com>
References: <44012D53.30700@undead.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44012D53.30700@undead.cc>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Zielinski <john_ml@undead.cc> :
[8139 failure]

Can you send lspci -vx, dmesg and lsmod after the hang ?

-- 
Ueimor
