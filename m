Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTDVTYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTDVTYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:24:42 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:43674 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S263482AbTDVTY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:24:29 -0400
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] fbcon
Date: Thu, 24 Apr 2003 01:05:21 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304240105.21711.b_adlakha@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a problem in the frame buffer console, It appears as if the 
resolution has been changed from 1024x768 to 1024x800 or something like that 
(I can only half see the sh prompt when it has come down), but the argument I 
passed at boot time was still 788. It doesn't appear to have been solved 
according to the bk csets taken from kernel.org.


