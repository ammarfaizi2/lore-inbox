Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbTGOIZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbTGOIZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:25:20 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:38531 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S266892AbTGOIZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:25:17 -0400
Date: Tue, 15 Jul 2003 10:40:06 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Carl Thompson <cet@carlthompson.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling modules outside of tree in 2.6.0test1
Message-Id: <20030715104006.79c58435.martin.zwickel@technotrend.de>
In-Reply-To: <1058251587.eec14da73ec3b@carlthompson.net>
References: <1058251587.eec14da73ec3b@carlthompson.net>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.0claws93 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 23:46:27 -0700
Carl Thompson <cet@carlthompson.net> bubbled:

What about:

CFLAGS += -I/usr/include/asm/mach-default/

-- 
MyExcuse:
Someone is broadcasting pygmy packets and the router doesn't know how to deal
with them.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
