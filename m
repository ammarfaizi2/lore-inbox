Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSFKMaC>; Tue, 11 Jun 2002 08:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSFKMaC>; Tue, 11 Jun 2002 08:30:02 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:20352 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317017AbSFKMaB>; Tue, 11 Jun 2002 08:30:01 -0400
Date: Tue, 11 Jun 2002 14:35:59 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bandwidth 'depredation' revisited
Message-ID: <3D05EEAF.mailZE11URHZ@viadomus.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I've took a look at the documentation related to Traffic Control
and Class Based Queuing, but all of them seems to deal with upload
bandwidth, so it won't solve my problem, which is that wget eats all
my download bandwidth.

    I know: downlink traffic cannot be shaped and Traffic Control is
for data WE send. So, am I missing something? Will my problem be solved
and download bandwidth shared between apps thru Traffic Control or
will I just get better interactive response?

    I think that I'm missing something here, but I'm clueless...

    Thanks in advance :)

    Raúl
