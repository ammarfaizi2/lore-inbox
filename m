Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933006AbWFZUGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbWFZUGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933003AbWFZUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:06:07 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:58473 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932998AbWFZUGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:06:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UvW/z5Rbup6Xr7cCBTcoMgTaL8f+kbqdGbHWGysC6jLnLNfkjbah54cr1jDspJ0FQMySITJkQIKjYz9bkxa3keD/BVBIXxpzjesQCti2uKyFy4ecaRsN8dWeYh/mV8plEMELPl35ZbV0JwdpIg0yhKZwjNAMe9C0mO2lellogjo=
Message-ID: <6bffcb0e0606261306i7f5a3326oa0c7f53aac2aa18d@mail.gmail.com>
Date: Mon, 26 Jun 2006 22:06:03 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: oom-killer problem
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I have noticed a small problem with
2.6.17-5fd571cbc13db113bda26c20673e1ec54bfd26b4 - in fact, it doesn't
work.

http://www.stardust.webpages.pl/files/linux/bug1.jpg
http://www.stardust.webpages.pl/files/linux/bug2.jpg

Here is a config file
http://www.stardust.webpages.pl/files/linux/config

Any ideas?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
