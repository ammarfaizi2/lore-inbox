Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTGUIzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 04:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269473AbTGUIzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 04:55:05 -0400
Received: from pd146.bielsko.sdi.tpnet.pl ([217.96.247.146]:64271 "EHLO
	aquila.wombb.edu.pl") by vger.kernel.org with ESMTP id S269451AbTGUIzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 04:55:02 -0400
Date: Mon, 21 Jul 2003 11:09:34 +0200
From: =?ISO-8859-2?B?UHJ6ZW15c7NhdyBTdGFuaXOzYXc=?= Knycz 
	<zolw@wombb.edu.pl>
To: <WHarms@bfs.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem linux-2.6.0-test1 on alpha
Message-Id: <20030721110934.0aa1aaeb.zolw@wombb.edu.pl>
In-Reply-To: <vines.sxdD+Gjg4zA@SZKOM.BFS.DE>
References: <vines.sxdD+Gjg4zA@SZKOM.BFS.DE>
Organization: RODN "WOM" =?ISO-8859-2?B?QmllbHNrby1CaWGzYQ==?=
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Sun, 20 Jul 2003 19:05:23 +0200
<WHarms@bfs.de>(Walter Harms) naszkroba³:

> I have tried 2.12,2.13,2.14 sofar, no success at all. did anyone else
> tried 2.6 on alpha ?

builds and works:
[root@pldmachine /root]# rpm -q gcc binutils modutils module-init-tools
gcc-3.3-3
binutils-2.14.90.0.4.1-1
modutils-2.4.25-4
module-init-tools-0.9.12-0.2
[root@pldmachine /root]# uname -a
Linux pldmachine 2.6.0 #1 Wed Jul 16 13:34:25 CEST 2003 alpha EV56
unknown PLD Linux

cheers

-- 
.----[ a d m i n at w o m b b dot e d u dot p l ]----.
| Przemys³aw Stanis³aw Knycz,  djrzulf@jabber.gda.pl |
| Net/Sys Administrator, PLD Developer,  RLU: 213344 |
`------ "Linux - the choice of GNU generation" ------'
