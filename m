Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUGBNEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUGBNEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUGBNEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:04:53 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.125.5]:4612 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264414AbUGBNEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:04:50 -0400
Date: Fri, 2 Jul 2004 16:58:04 +0200 (CEST)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ERROR] external kernel module build 
Message-ID: <Pine.LNX.4.58L.0407021651190.17342@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try to build external kernel module
I use this:  http://lkml.org/lkml/2004/4/20/129 to make modules.
and:
make -j5 -C /usr/src/linux clean modules 
M=/home/users/cieciwa/rpm/BUILD/hostap-driver-0.2.2/driver/modules 
O=/home/users/cieciwa/rpm/BUILD/hostap-driver-0.2.2/driver/modules
make: Entering directory `/usr/src/linux-2.6.7'
make[1]: *** No rule to make target `clean'.  Stop.
make: *** [clean] Error 2
make: *** Waiting for unfinished jobs....
make[1]: *** No rule to make target `modules'.  Stop.
make: *** [modules] Error 2
make: Leaving directory `/usr/src/linux-2.6.7'
error: Bad exit status from /var/tmp/rpm-tmp.97520 (%build)


Can any one tell me what wrong?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
