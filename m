Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318778AbSICNhO>; Tue, 3 Sep 2002 09:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318780AbSICNhO>; Tue, 3 Sep 2002 09:37:14 -0400
Received: from 62-190-219-194.pdu.pipex.net ([62.190.219.194]:30727 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318778AbSICNhN>; Tue, 3 Sep 2002 09:37:13 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209031348.g83Dm0Jb003201@darkstar.example.net>
Subject: Re: [kde-linux] Can't find qt libs...
To: gene_heskett@iolinc.net (Gene Heskett)
Date: Tue, 3 Sep 2002 14:48:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, kde-linux@mail.kde.org
In-Reply-To: <200209030904.49101.gene_heskett@iolinc.net> from "Gene Heskett" at Sep 03, 2002 09:04:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And its not just kde. I have several things that won't configure 
> because the *&%&^%$ libqt-mt.so in >= qt-3.0.2 can't be found.  
> There are 4 copies of 3.0.4 scattered about my system.  Its a real 
> problem that so far evertone seems to think will go away if our 
> $QTDIR is set correctly, and/or we use the --with-qt-libs= options.
> 
> It doesn't go away no matter how much the rest of this list wishes 
> *we* would.

Err, it sounds to me like you are not running ldconfig after installing a library.  Are you?

John.
