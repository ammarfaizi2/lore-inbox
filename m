Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbVBELAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbVBELAq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbVBEK75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:59:57 -0500
Received: from styx.xnull.de ([213.133.98.19]:2522 "EHLO styx.xnull.de")
	by vger.kernel.org with ESMTP id S261837AbVBEKqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:46:31 -0500
Message-ID: <4204B1D2.9070609@mglug.de>
Date: Sat, 05 Feb 2005 11:45:22 +0000
From: Axel Schmalowsky <schmalowsky@mglug.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: L1_CACHE
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Can anyone tell me if it is destruktive or does it cause lose of 
performance if I set up
L1_CACHE_SHIFT_MAX as well as CONFIG_X86_L1_CACHE_SHIFT to the value of 10?

I've an Intel centrino processor with 1MB L1-Cache.

Thanx in advance

Axel
