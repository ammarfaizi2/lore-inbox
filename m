Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935611AbWK1Faj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935611AbWK1Faj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 00:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935613AbWK1Faj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 00:30:39 -0500
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:61401 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S935611AbWK1Faj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 00:30:39 -0500
Message-ID: <456BC973.1050309@feise.com>
Date: Mon, 27 Nov 2006 21:30:27 -0800
From: Joe Feise <jfeise@feise.com>
Reply-To: jfeise@feise.com
Organization: feise.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [2.6 patch] remove the broken VIDEO_ZR36120 driver
References: <20061125191510.GB3702@stusta.de>
In-Reply-To: <20061125191510.GB3702@stusta.de>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote on 11/25/06 11:15:

> The VIDEO_ZR36120 driver has:
> - already been marked as BROKEN in 2.6.0 three years ago and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be 
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still 
> present in the older kernel releases.

Hmm, there are people out there (like me) who still use it and have patched it
to get it working on 2.6.x.

-Joe

