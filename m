Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTEXQS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 12:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTEXQS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 12:18:29 -0400
Received: from smtp3.poczta.onet.pl ([213.180.130.29]:18096 "EHLO
	smtp3.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262114AbTEXQS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 12:18:28 -0400
Message-ID: <3ECF9E4F.302@poczta.onet.pl>
Date: Sat, 24 May 2003 18:31:11 +0200
From: Gutko <gutko@poczta.onet.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.4b) Gecko/20030507
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: broken vesafb on 2.4.21-rc3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have compiled in vesafb. My Radeon 9700 is running on lastest ATI 
drivers in X. Everything is ok , till I enter X and then exit. After 
exiting console is totally messed up. There is no chance to even read a 
single character.Kernel is patched with nforce2 agp support Everything 
was ok on 2.4.21-rc2-ac3 which I also patched with nforce2 agp.

Asus A7N8X-deluxe on nforce2
Radeon 9700

Sorry for such poor describe of bug but I'm new to linux:(

Gutko


