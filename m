Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbTENG3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTENG3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:29:06 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:20632 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S262335AbTENG3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:29:04 -0400
Date: Wed, 14 May 2003 08:41:48 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: cannot boot 2.5.69
Message-ID: <Pine.LNX.4.44.0305140839390.1872-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I still find no way to boot a 2.5.69 kernel.
It reports: "no console found, specify init= option"
But the console is specified and the messages appear till this point:

This is the relevant part of my config:
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_LP_CONSOLE is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

What am I missing?
Pau


