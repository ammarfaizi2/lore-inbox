Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272175AbRIFABs>; Wed, 5 Sep 2001 20:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272359AbRIFAB2>; Wed, 5 Sep 2001 20:01:28 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:22242 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S272175AbRIFABY>; Wed, 5 Sep 2001 20:01:24 -0400
Date: Wed, 5 Sep 2001 16:04:32 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Serial Ports
Message-ID: <Pine.LNX.4.33.0109051603160.2980-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should serial ports be assigned interrupts on start up or are they
assigned when they are used? I have been tracking the serial ports on my
Supermicro Dual P3 Board for a few days now. At times I cannot get them to
work so I can syncronize a Palm Pilot via the serial port.

Stephen

