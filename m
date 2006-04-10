Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWDJRfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWDJRfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWDJRfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:35:13 -0400
Received: from lucidpixels.com ([66.45.37.187]:55272 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751117AbWDJRfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:35:12 -0400
Date: Mon, 10 Apr 2006 13:34:56 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.16.2 - I2C SMBus Quick command not supported
Message-ID: <Pine.LNX.4.64.0604101333221.5884@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[4294696.252000] i2c_adapter i2c-1: SMBus Quick command not supported, 
can't probe for chips
[4294696.252000] i2c_adapter i2c-2: SMBus Quick command not supported, 
can't probe for chips
[4294696.252000] i2c_adapter i2c-3: SMBus Quick command not supported, 
can't probe for chips

My sensors continue to work fine, but up to 2.6.15, I had no issues, I 
manually compile the I2C options in that are relative to my hardware.  Are 
these errors now `normal' in 2.6.16.x?

Thanks,

Justin.
