Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVKJTDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVKJTDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVKJTDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:03:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61078 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932157AbVKJTD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:03:29 -0500
Date: Thu, 10 Nov 2005 20:02:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Giuliano Pochini <pochini@shiny.it>
cc: alex@alexfisher.me.uk, linux-kernel@vger.kernel.org,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
In-Reply-To: <XFMail.20051102104916.pochini@shiny.it>
Message-ID: <Pine.LNX.4.61.0511102002160.17092@yvahk01.tjqt.qr>
References: <XFMail.20051102104916.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> So despite the fact the driver has been written in c++, it
>> might be possible to write a usable specification.
>
>Linux 2.6 doesn't accept c++, so you have to rewrite it anyway.

It does, to a limited degree. Just look at the VMware vmmon/vmnet driver 
sources.

>You should ask them if you can publish your own driver based
>on infos you extract from their driver.



Jan Engelhardt
-- 
