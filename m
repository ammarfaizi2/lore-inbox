Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUAGWj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUAGWj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:39:26 -0500
Received: from smtp3.libero.it ([193.70.192.127]:4528 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S262078AbUAGWjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:39:25 -0500
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Documentation about input events - Was [Re: Trouble with lineak and 2.6 kernel]
Date: Wed, 7 Jan 2004 23:40:17 +0100
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401072340.17288.dgp85@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because I think there will be no simple solutions using the atkbd driver I was 
thinking about trying to write an auxiliary driver that uses input events to 
send them to userspace (and then try to write a daemon to make them work).
The only problem is... that I don't know where to start.
Can anyone tell me where to find doc about input events? Thanks.

-- 
Flameeyes <dgp85@users.sourceforge.net>
You can find LIRC for 2.6 kernels at
http://flameeyes.web.ctonet.it/
