Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVCVUO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVCVUO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVCVUO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:14:28 -0500
Received: from smtp.telefonica.net ([213.4.129.135]:5434 "EHLO
	tnetsmtp1.mail.isp") by vger.kernel.org with ESMTP id S261886AbVCVUNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:13:46 -0500
Message-ID: <42407C75.3010309@telefonica.net>
Date: Tue, 22 Mar 2005 21:13:41 +0100
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: touchpad dragging problem
References: <422618F0.3020508@telefonica.net>	<20050321141049.5d804609.akpm@osdl.org>	<423FE7C5.8080402@telefonica.net> <m3acovzeb5.fsf_-_@telia.com>
In-Reply-To: <m3acovzeb5.fsf_-_@telia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:

>What parameter settings do you use in the X driver? If you have
>SHMConfig enabled, you can run "synclient -l" to find out. Does
>increasing MaxTapTime help?
>  
>
Yes, after setting MaxTapTime to "180" I can drag comfortably. In fact, 
keeping the default one ("120"), I can drag if I start the drag movement 
just after the second tap. Maybe I had to play around with the values 
before and keep from polluting the kernel mailing list ;P

