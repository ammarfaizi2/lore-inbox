Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWE1JpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWE1JpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 05:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWE1JpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 05:45:05 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:21107 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932115AbWE1JpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 05:45:03 -0400
Message-ID: <4479759C.8050104@gentoo.org>
Date: Sun, 28 May 2006 11:04:12 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060509)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux and Wireless USB Adaptor
References: <44793F44.1040603@perkel.com>
In-Reply-To: <44793F44.1040603@perkel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Marc Perkel wrote:
> I have an Airlink Wireless USB 2.0 adaptor. Does it work with Linux? If 
> so - what do I have to do to make it work?

Is it an AWLL3025 or an AWLL3026?

If so, it is based on the ZD1211 chip. You can download a community 
maintained version of the vendor driver here: http://zd1211.ath.cx/

Or you can try the rewritten version which we aim to get included in 
2.6.18 or 2.6.19: http://zd1211.ath.cx/wiki/DriverRewrite

Daniel
