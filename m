Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272066AbTHDSGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272060AbTHDSGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:06:49 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:2789 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S272066AbTHDSGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:06:48 -0400
Date: Mon, 4 Aug 2003 20:05:59 +0200
To: linux-kernel@vger.kernel.org
Subject: [APM ERROR-REPORT] APM_DISPLAY_BLANK freezes Thinkpad R40 and Sony Z1 on suspend
Message-ID: <20030804180559.GA31178@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19jjiZ-000879-00*bGIG7WaJWyM* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        hy,


enable CONFIG_APM_DISPLAY_BLANK on linux 2.4.22-pre10 and
2.4.22-pre10-ac1 freeze my Thinkpad R40 with Ati Mobile 7500 and Sony Z1
on apm -s.

        Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
