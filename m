Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270266AbUJUHip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270266AbUJUHip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270333AbUJUHhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:37:24 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24545 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270266AbUJUHeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:34:19 -0400
Date: Thu, 21 Oct 2004 09:33:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: r8169 - dac testing (was: [mini-RFT] r8169 and amd64)
Message-ID: <20041021073333.GA29423@electric-eye.fr.zoreil.com>
References: <200410221112.18575.sriharivijayaraghavan@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410221112.18575.sriharivijayaraghavan@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> :
[...]
> r8169: eth0: PCI error (cmd = 0x0017, status = 0x22b0).
> eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
> 
> And the network card does not work, as I cannot ping another host (DSL 
> modem/router) on the network.
> 
> (Once I load the module with that parameter, unloading and reloading it 
> without that parameter does not bring the network card back to its working 
> configuration.)

Thanks a lot.

- it does not crash but it did not recover;
- no difference with the newly reported PCI error under load on a 32bit host.

Bad mojo.

--
Ueimor
> 
