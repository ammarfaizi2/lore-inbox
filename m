Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTJ0K6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 05:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTJ0K6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 05:58:10 -0500
Received: from smtp01.web.de ([217.72.192.180]:11026 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261563AbTJ0K6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 05:58:10 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 Lilo problem
Date: Mon, 27 Oct 2003 11:59:09 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310271159.09681.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I intensively tested several kernel options and had to install a new kernel 
quite often and since I'm using Lilo also had to re-running lilo rather 
often. However, sometimes (about 30%) it happend after I rebooted that the 
lilo-boot-menu didn't appear but it stopped at 'L' and then filled my screen 
with '9''s.
This only happens with 2.6.0-testX and not with 2.4.X, furthermore I think it 
might be sync related, since it never happend when I manually run the sync 
programm several times aftter I run 'lilo'

Is it a lilo or kernel bug? 

Cheers,
	Bernd

