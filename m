Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271042AbTGQHjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 03:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271071AbTGQHjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 03:39:05 -0400
Received: from pd146.bielsko.sdi.tpnet.pl ([217.96.247.146]:61965 "EHLO
	aquila.wombb.edu.pl") by vger.kernel.org with ESMTP id S271042AbTGQHjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 03:39:03 -0400
Date: Thu, 17 Jul 2003 09:24:32 +0200
From: =?ISO-8859-2?B?UHJ6ZW15c7NhdyBTdGFuaXOzYXc=?= Knycz 
	<zolw@wombb.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [linux-2.6.0-test1] Missing #include lines with alsa at alpha
Message-Id: <20030717092432.5737d88c.zolw@wombb.edu.pl>
Organization: RODN "WOM" =?ISO-8859-2?B?QmllbHNrby1CaWGzYQ==?=
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've noticed that alsa_lib.c have missed afair #include linux/module.h
or init.h. Somebody is more oriented at this problem ? I've fixed it,
but i must test it, after that i can send the patch ;)

cheers

-- 
.----[ a d m i n at w o m b b dot e d u dot p l ]----.
| Przemys³aw Stanis³aw Knycz,  djrzulf@jabber.gda.pl |
| Net/Sys Administrator, PLD Developer,  RLU: 213344 |
`------ "Linux - the choice of GNU generation" ------'
