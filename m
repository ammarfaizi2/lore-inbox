Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751979AbWG1Ia4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWG1Ia4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWG1Ia4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:30:56 -0400
Received: from www.nabble.com ([72.21.53.35]:38103 "EHLO talk.nabble.com")
	by vger.kernel.org with ESMTP id S1751979AbWG1Ia4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:30:56 -0400
Message-ID: <5535638.post@talk.nabble.com>
Date: Fri, 28 Jul 2006 01:30:55 -0700 (PDT)
From: "heavenscape (sent by Nabble.com)" <lists@nabble.com>
Reply-To: heavenscape <masonduan1@sina.com>
To: linux-kernel@vger.kernel.org
Subject: How to port a legacy device driver to a new Linux platform?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-Sender: lists@nabble.com
X-Nabble-From: heavenscape <masonduan1@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have a legacy PCI fiber card running under Red Hat Linux 7.3, and I have
all the source code of its driver developped by others. Please see the
attachment.

http://www.nabble.com/user-files/135/cyport71.tar cyport71.tar 

It is working fine right now. But I am going to upgrade my OS to Rea Hat
Enterprise Linux AS 4, I am not sure how can I recompile and install this
fiber card in the new OS.  I am new to Linux and have minimal experience in
programming Linux. But this card is very important to me.

Any suggestion is highly appreciated!!  Thanks!!

Mason
-- 
View this message in context: http://www.nabble.com/How-to-port-a-legacy-device-driver-to-a-new-Linux-platform--tf2014157.html#a5535638
Sent from the linux-kernel forum at Nabble.com.

