Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbTHXTLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 15:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTHXTLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 15:11:32 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:8650 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261278AbTHXTL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 15:11:29 -0400
Message-ID: <3F490E27.80609@myrealbox.com>
Date: Sun, 24 Aug 2003 12:12:39 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030805
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Silicon Image 680 support in 2.6?
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been talking to someone who has good support for his
SII680 disk controller in 2.4 but he can't get it working
in 2.6.

Is this chip supported yet in 2.6?  I see the chip mentioned
in Andre's code in siimage.h, but apparently this fellow's
dmesg doesn't say anything about the chip being found at boot.

