Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVEIIkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVEIIkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 04:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVEIIke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 04:40:34 -0400
Received: from mx.laposte.net ([81.255.54.11]:13379 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261151AbVEIIka convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 9 May 2005 04:40:30 -0400
Date: Mon,  9 May 2005 10:40:29 +0200
Message-Id: <IG7S3H$ECDE8351FD5BB869516C40901B57C29E@laposte.net>
Subject: Raouf From Tunisia
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "aguel\.raouf" <aguel.raouf@laposte.net>
To: "Linux-Kernel" <Linux-Kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B51)
X-type: 0
X-SenderIP: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi


I must modify my distro to not test the status of root
directory  (whether it is (is not) writable). For example,
Slackware is testing the status of the root partition during
boot and if it's read-write,it will display a message and will
wait for user input. This is something we don't like, right?
Unionfs can't be remounted ro, to skip the test. i will need
to do something for my distro.
I want to know what i can do, how i can patch my distro

thanks have a good day 

Accédez au courrier électronique de La Poste : www.laposte.net ; 
3615 LAPOSTENET (0,34€/mn) ; tél : 08 92 68 13 50 (0,34€/mn)



