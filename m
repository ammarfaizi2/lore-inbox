Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVCWJYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVCWJYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCWJYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:24:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5557 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262894AbVCWJXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:23:52 -0500
Date: Wed, 23 Mar 2005 10:23:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfs: remove a redundant NULL pointer check prior to
 kfree()
In-Reply-To: <200503231104.10704.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.61.0503231023070.19506@yvahk01.tjqt.qr>
References: <Pine.LNX.4.62.0503222351350.2683@dragon.hyggekrogen.localhost>
 <200503231104.10704.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>IIRC devfs is deprecated and has less than a year to live.

What are we waiting for, then?


Jan Engelhardt
-- 
