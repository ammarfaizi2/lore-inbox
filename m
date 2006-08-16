Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWHPXNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWHPXNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWHPXNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:13:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750746AbWHPXNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:13:41 -0400
Date: Thu, 17 Aug 2006 01:13:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: avr32@atmel.com, hskinnemoen@atmel.com
Cc: linux-kernel@vger.kernel.org
Subject: please add an arch/avr32/defconfig
Message-ID: <20060816231340.GK7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add an arch/avr32/defconfig.

The purposes of a defconfig are:
- starting point for people compiling their own kernel
- usable configuration for compile tests

It doesn't need to be anything special, e.g. a working .config from a 
machine you are using would be a suitable defconfig.

TIA
Adrian

BTW: What is the status of getting avr32 support into upstream
     binutils and gcc?

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

