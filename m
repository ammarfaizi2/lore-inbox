Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUCNSrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUCNSrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:47:49 -0500
Received: from nat20.camtrial.co.uk ([193.117.99.116]:43905 "EHLO cdmnet.org")
	by vger.kernel.org with ESMTP id S261464AbUCNSrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:47:48 -0500
Message-ID: <4054A8D2.4070302@cdmnet.org>
Date: Sun, 14 Mar 2004 18:47:46 +0000
From: Calum Mackay <calum.mackay@cdmnet.org>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040314)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.4 & new e100 driver: module load parameters
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I'm missing something obvious, but the new e100 driver seems to 
have lost all the module load parameters (still) referenced in 
Documentation/networking/e100.txt, e.g. e100_speed_duplex.

Does the new driver support module-load-time configuration of these 
settings, or do I now need a startup script that hacks around with ethtool?

[and perhaps the e100.txt file needs to be updated?]

please forgive my ignorance... :(

cheers,
c.
