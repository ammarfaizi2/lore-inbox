Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbUKMXVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUKMXVE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUKMXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:21:04 -0500
Received: from www.hyp-net.com ([213.41.136.115]:56193 "EHLO smtp.hyp-net.com")
	by vger.kernel.org with ESMTP id S261168AbUKMXVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:21:00 -0500
Message-ID: <419696C2.7020407@hyp-net.com>
Date: Sun, 14 Nov 2004 00:20:34 +0100
From: Christophe Bienaime <christophe@hyp-net.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SATA II 150 TX4 module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have bought a controller card Promise SATA II 150 TX4 (PDC 20265)
It doesn't seem supported by the module SCSI_SATA_PROMISE on a kernel 
2.6.9. (Because version 2)


the result of lspci :
 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 3d18 (rev 02)

I came back to a kernel 2.4.27 because the promise's module  can't be 
compiled on a 2.6.9.

The problem is , I can't boot my system on the with this solution


Is a module envisaged for this card? (or maybe another solution)

Christophe
