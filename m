Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVLMPut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVLMPut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLMPut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:50:49 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:27275 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932303AbVLMPus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:50:48 -0500
Message-ID: <439EEDD4.9030909@gentoo.org>
Date: Tue, 13 Dec 2005 15:50:44 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       r3pek@gentoo.org
Subject: Re: [patch 09/26] DVB: BUDGET CI card depends on STV0297 demodulator
References: <20051213073430.558435000@press.kroah.org> <20051213082242.GJ5823@kroah.com>
In-Reply-To: <20051213082242.GJ5823@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Daniel Drake <dsd@gentoo.org>
> 
> This patch solves a DVB driver compile error introduced in 2.6.14
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Sorry, I accidently dropped the headers when submitting this.  The correct 
headers are as below:



From: Carlos Silva <r3pek@gentoo.org>

[PATCH] DVB: BUDGET CI card depends on STV0297 demodulator.

BUDGET_CI card depends on STV0297 demodulator.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

