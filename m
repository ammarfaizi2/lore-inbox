Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbSL2Ini>; Sun, 29 Dec 2002 03:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSL2Ini>; Sun, 29 Dec 2002 03:43:38 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:39041 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S266497AbSL2Inh>; Sun, 29 Dec 2002 03:43:37 -0500
Subject: 2.5 module loading with redhat 8
From: Sipos Ferenc <sferi@mail.tvnet.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041152019.1329.3.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 29 Dec 2002 09:53:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have compiled the 2.5.53 kernel, installed rusty's modutils package,
made a symlink modutils.conf-modules.conf, but the modules haven't been
preloaded during boot, and this hangs the cups initscript for me, hoever
iptables is complaining. Does anybody have a modified initscript to
solve the problem, or it is already in rawhide?

Paco
