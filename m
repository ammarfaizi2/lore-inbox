Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbTGONBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbTGONBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:01:47 -0400
Received: from mail.zmailer.org ([62.240.94.4]:46997 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S268051AbTGONBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:01:46 -0400
Date: Tue, 15 Jul 2003 16:16:34 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: VGER ran out of /var/tmp/ space, and lists lost emails.
Message-ID: <20030715131634.GF6898@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... 15 to 9 hours ago it was all out, and majordomo failed during that
about 6 hours.  (About 14th Jul 23:00 UTC to 15th Jul 04:00 UTC)

 http://vger.kernel.org/z/zmailer-rrd-vger_SNMP_SYS_LogFreeSpace-kB-G.html

Several log files failed to log (or rotate), Majordomo failed to create
temporary files, and didn't detect it, thus messages got lost...

D'uh..  These should never happen, but still they do :-/

/Matti Aarnio -- one of VGER's postmasters
