Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSHCD3k>; Fri, 2 Aug 2002 23:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSHCD3k>; Fri, 2 Aug 2002 23:29:40 -0400
Received: from h-64-105-137-93.SNVACAID.covad.net ([64.105.137.93]:6017 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317435AbSHCD3k>; Fri, 2 Aug 2002 23:29:40 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 2 Aug 2002 20:32:57 -0700
Message-Id: <200208030332.UAA06740@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: A new ide warning message
Cc: axboe@suse.de, B.Zolnierkiewicz@elka.pw.edu.pl, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>Look again Jens. Adam's changes made IDE queue handling inconsistent.
>hint: 2 * 127 != 255

	I've discussed this with Bartlomiej by email now and we've
determined that we he was referring to was not a bug after all.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
