Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTFYSxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTFYSwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:52:55 -0400
Received: from smtp2.libero.it ([193.70.192.52]:2531 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S264985AbTFYSvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:51:52 -0400
Subject: PPP Modem connection impossible with 2.5.73-bk2
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1056567978.931.8.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 25 Jun 2003 21:06:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
After the upgrade from 2.5.73-bk1 to bk2 the pppd daemon is killed, so
the ppp connection is impossible.
After the reverse of the patch I can connect.
I also applied the bk2-bk3 patch (without the bk2), and I have no
problems.
So the problem is in bk2.
-- 
Flameeyes <dgp85@users.sf.net>

