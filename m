Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRDBACg>; Sun, 1 Apr 2001 20:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132581AbRDBAC1>; Sun, 1 Apr 2001 20:02:27 -0400
Received: from h004005a2c41c.ne.mediaone.net ([24.147.52.101]:16135 "EHLO
	neuromancer.BakerConsulting.com") by vger.kernel.org with ESMTP
	id <S132584AbRDBACJ>; Sun, 1 Apr 2001 20:02:09 -0400
Subject: Possible Bug: Kernel Parameter 'scsihosts' Doesn't Work In 2.4.3?
From: Thomas "J." Baker <tjb@bakerconsulting.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10+cvs.2001.04.01.08.06 (Preview Release)
Date: 01 Apr 2001 20:05:45 -0400
Message-Id: <986169946.1709.3.camel@neuromancer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the 'scsihosts' kernel parameter broken in 2.4.3?  It has worked in
2.4.0 - 2.4.2 but doesn't seem to now.  Using 

append="apm=power-off scsihosts=aic7xxx,BusLogic"

in my lilo.conf, the BusLogic is found first.

Thanks,

tjb



