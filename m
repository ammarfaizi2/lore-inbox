Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVCaPEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVCaPEw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVCaPD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:03:58 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:58738 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261497AbVCaPBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:01:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=VMPiSofsVjJH4Tb2//J0iMNM6uQyzl3ixFqrcdT549brxfSlx5Ye3DfVU3oYLw1m11MQpon58h3GEPR08VeXB/YflH9MzIiPpfKwZ88+5vCP7UZlWsfSACZt3np1zbcHhLt8NNeiFk62TVlvsUfrpFkvgIwm9yrGAU1Wxz/1s/k=
Message-ID: <424C10C3.9080102@gmail.com>
Date: Fri, 01 Apr 2005 00:01:23 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Cc: mage@adamant.ua
Subject: sata_sil Mod15Write quirk workaround patch for vanilla kernel avaialble.
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello, guys.

 I  generated m16w workaround patch for 2.6.11.6 (by just removing two
lines :-) and set up a page regarding m15w quirk and the workaournd.
I'm planning on updating m15w patch against the vanilla tree until it
gets into the mainline so that impatient users can try out and it gets
more testing.

 http://home-tj.org/m15w

 Thanks.

-- 
tejun

