Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSIHRn5>; Sun, 8 Sep 2002 13:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSIHRn5>; Sun, 8 Sep 2002 13:43:57 -0400
Received: from mta2n.bluewin.ch ([195.186.4.220]:32702 "EHLO mta2n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S318107AbSIHRn5>;
	Sun, 8 Sep 2002 13:43:57 -0400
Message-ID: <3D7BA992.113333E@bluewin.ch>
Date: Sun, 08 Sep 2002 19:48:34 +0000
From: Mario Vanoni <vanonim@bluewin.ch>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre5aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4-pre5[{-}xyz]: 4 machines, feedback only
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gr4: UP PIII550 1GB mem SCSI only, 4 HD's
gr5: UP Celeron996 512MB mem IDE. 2 HD's
va1: dual SMP PIII550 1GB mem SCSI only, 4 HD's
va3: dual SMP PIII1266 2GB mem,
     SCSI HD's (4), IDE DVD + burner

2.4.20-pre5: all machines OK >24h

2.4.20-pre5aa1: gr4 network 10Mbits/BNC _dead_,
                gr5, va1 and va3 OK >24h

2.4.20-pre5-ac4: gr4 & va1 OK, >24h
                 gr5 & va3 _not_ compilable,
                 at ide/idedriver.o stop

All kernels _without_ modules, pure static,
and no other patches.

Regards

Mario, _not_ in lmkl

PS gr4 is a production machine,
   touchable maybe on weekends !!!
