Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSFKHiu>; Tue, 11 Jun 2002 03:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSFKHit>; Tue, 11 Jun 2002 03:38:49 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:1152 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316883AbSFKHis>; Tue, 11 Jun 2002 03:38:48 -0400
Date: Tue, 11 Jun 2002 09:44:46 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: bandwidth 'depredation'
Message-ID: <3D05AA6E.mailKB1BHA1W@viadomus.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))
    
    I've noticed that, when using certain programs like 'wget', the
bandwidth seems to be 'depredated' by them. When I download a file
with lukemftp or with links, the bandwidth is then distributed
between all IP clients, but when using wget or some ftp clients, it
is not distributed. BTW, I'm using an ADSL line (128 up / 256 down).

    IMHO, the IP layer (well, in this case the TCP layer) should
distribute the bandwidth (although I don't know how to do this), and
the kernel seems to be not doing it.

    I don't know if this is the intended behaviour or even if this is
a kernel fault or not, but I think that is not good ;)

    Thanks :)
    Raúl
