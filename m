Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272874AbTHEQzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272900AbTHEQxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:53:30 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:53652 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S272875AbTHEQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:51:38 -0400
Date: Tue, 5 Aug 2003 18:50:58 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org, marekm@linux.org.pl
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test2 - Watchdog patches (advantechwdt.c)
Message-ID: <20030805185058.A13304@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog

This will update the following files:

 drivers/char/watchdog/advantechwdt.c |  139 ++++++++++++++++++++---------------
 1 files changed, 82 insertions(+), 57 deletions(-)

through these ChangeSets:

<wim@iguana.be> (03/08/05 1.1605)
   [WATCHDOG] advantechwdt patches
   
   use module_param, removed __setup code,
   general cleanup (mostly of comments and trailing spaces, also removed include of config.h),
   made the watchdog's timeout a module_param.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog

Greetings,
Wim.

