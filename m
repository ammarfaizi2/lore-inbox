Return-Path: <linux-kernel-owner+w=401wt.eu-S1754684AbWL0TfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbWL0TfR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 14:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbWL0TfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 14:35:17 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:39605 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684AbWL0TfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 14:35:16 -0500
Date: Wed, 27 Dec 2006 20:35:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux tcp stack behavior change
In-Reply-To: <Pine.LNX.4.61.0612270258450.14578@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0612272034320.10556@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0612270258450.14578@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 27 2006 03:03, Jan Engelhardt wrote:
>
>I have been noticing that running nmap -sF on oneself does not generate 
>a reply from the TCP stack on 2.6.18(.5). In other words:
[...]

Alright same behavior on 2.6.13 and nmap 3.81, so the problem is 
somewhere on my side having misdocumented something back then.


	-`J'
-- 
