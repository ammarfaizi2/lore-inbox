Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVKPPnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVKPPnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVKPPnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:43:23 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:21282 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030364AbVKPPnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:43:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M79FIa+xzRTwqis57P41D6RgUyOZTAL931oSfZeVk9rdfAqq3ryfanDPmElj11Ffaqv5gdA54JWa6j7CrfhSLj1iKFnnNN/Gl5YXeJXxbehj1bKLsoxNl4jkg0lWDfauLM22SGz06RoJrxUYPiJrivnkMkCcjSFUu9CkHgRkcP4=
Message-ID: <a59861030511160743l19b7be6bn@mail.gmail.com>
Date: Wed, 16 Nov 2005 16:43:22 +0100
From: Ivan Korzakow <ivan.korzakow@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: fast communication problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I'm running a 2.6.14 linux on 96 MHz MIPS processor. I need to cope
with a device that sends a byte of data every 50 microsecond through
an UART with no FIFO. What would be the best (well, the least
horrible) way to handle that ? The good point is that I know when the
communication starts.

Any idea, any help, any "good luck" will be much appreciated !

Thanks in advance,

Ivan
