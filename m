Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbUKDRxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUKDRxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbUKDRs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:48:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262332AbUKDRsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:48:00 -0500
Message-ID: <418A6B41.8070502@pobox.com>
Date: Thu, 04 Nov 2004 12:47:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'matt_domsch@dell.com'" <matt_domsch@dell.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: EDD: 30-second delay
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW, on my Athlon64 box, the 30 second delay appears when the PATA 
controller is diabled in BIOS, and disappears when the PATA controller 
is enabled in BIOS.  There are no devices attached to the PATA controller.

Sounds like a BIOS EDD bug to me...

	Jeff



