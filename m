Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbTAARLC>; Wed, 1 Jan 2003 12:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTAARLC>; Wed, 1 Jan 2003 12:11:02 -0500
Received: from mail-fe73.tele2.ee ([212.107.32.238]:11447 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S264983AbTAARLB>;
	Wed, 1 Jan 2003 12:11:01 -0500
Date: Wed, 1 Jan 2003 19:19:24 +0200
Message-Id: <200301011719.h01HJOB21702@mail-fe2.tele2.ee>
To: linux-kernel@vger.kernel.org
Subject: 3rdparty modules for 2.5.53
From: Albert Kajakas <Albert.Kajakas@mail.ee>
X-Mailer: www.mail.ee
X-Login-From: 80.235.70.104::
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!
I have a problem with compiling modules for 2.5.
i wrote a module for 2.4. For 2.5 (51,52,53) it compiles nicely, but insmod complains about invalid format. I have the latest module init tools of Rusty installed.  I'm usin gcc 3.2. Do i have to use any special compiler/linker options or defines or whatever to generate a working module ? what could be the problem ? Even a simple hello-world module doesnt work. Although, i have a working 2.5.53 modular kernel that was built using same tools.

best,
Al.
-- everyday.com --
Kuidas elad, Eesti tudeng? 
Osale Tõnis Paltsu esseekonkursil üliõpilastele, 
auhinnafond 10 000 kr. http://www.palts.ee/?id=756
Häid pühi soovides, Tõnis Palts


