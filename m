Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbUKXXFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUKXXFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbUKXXEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:04:04 -0500
Received: from mail.apsecure.com ([65.39.139.58]:2178 "EHLO mail.apsecure.com")
	by vger.kernel.org with ESMTP id S262875AbUKXWym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:54:42 -0500
Message-ID: <011801c4d270$cca65740$0101140a@fortinet.com>
From: "Wenping  Luo" <wluo@fortinet.com>
To: <linux-kernel@vger.kernel.org>
Subject: ethernet Via-rhine driver 1.1.17 duplex detection issue in linux kernel 2.4.25
Date: Wed, 24 Nov 2004 13:58:58 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Fortimail-Filter: processed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used crossed ethernet cable to connect one ethernet NIC to a Via Rhine III
VT6105M NIC. I set the speed mode of Rhine Nic to be "auto" whereas I forced
the peer NIC to be "100 Full Duplex". The Rhine NIC connected in mode of
"100 Half Duplex" , instead of "100 Full Duplex", after detecting the peer.

I searched the Internet and I found another reported for similiar issue at
http://lunar-linux.org/pipermail/lunar/2004-April/003894.html. However,
there is no answer for this issue yet.

Thanks,

Wenping Luo

