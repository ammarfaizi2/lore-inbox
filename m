Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbTGUKOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 06:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269601AbTGUKOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 06:14:11 -0400
Received: from pd146.bielsko.sdi.tpnet.pl ([217.96.247.146]:34064 "EHLO
	aquila.wombb.edu.pl") by vger.kernel.org with ESMTP id S269583AbTGUKOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 06:14:11 -0400
Date: Mon, 21 Jul 2003 12:29:09 +0200
From: =?ISO-8859-2?B?UHJ6ZW15c7NhdyBTdGFuaXOzYXc=?= Knycz 
	<zolw@wombb.edu.pl>
To: lgb@lgb.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: buffer layer error at fs/buffer.c:416
Message-Id: <20030721122909.777b8196.zolw@wombb.edu.pl>
In-Reply-To: <20030721093021.GA16319@vega.digitel2002.hu>
References: <20030721093021.GA16319@vega.digitel2002.hu>
Organization: RODN "WOM" =?ISO-8859-2?B?QmllbHNrby1CaWGzYQ==?=
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Mon, 21 Jul 2003 11:30:21 +0200
Gábor Lénárt <lgb@lgb.hu> naszkroba³:

> Kernel is 2.6.0-test1, all filesystems are ext3.

I have the same problem with XFS, no problem seems to be with ext2. But
only at ide disk, at scsi disc with XFS i haven't problems (qlogicisp) -
btw there is written that (when loading qlogicisp) "error handling isn't
written" sweet ;) ;P

-- 
.----[ a d m i n at w o m b b dot e d u dot p l ]----.
| Przemys³aw Stanis³aw Knycz,  djrzulf@jabber.gda.pl |
| Net/Sys Administrator, PLD Developer,  RLU: 213344 |
`------ "Linux - the choice of GNU generation" ------'
