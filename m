Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTIITWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTIITVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:21:21 -0400
Received: from molly.vabo.cz ([160.216.153.99]:31756 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S264300AbTIITUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:20:31 -0400
Date: Tue, 9 Sep 2003 21:21:08 +0200 (CEST)
From: Tomas Konir <moje@vabo.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 can't unload module
Message-ID: <Pine.LNX.4.53.0309092108570.2624@moje.vabo.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
I tried to unload module 3x59x, but the module is immediately back and  
when I try to unload it for the second time the rmmod will stay in S state 
and can't be traced. I have only this message in log:

kernel: unregister_netdevice: waiting for eth0 to become free. Usage count 
= 4 

	MOJE

-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167
