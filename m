Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280593AbRKFVdp>; Tue, 6 Nov 2001 16:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280586AbRKFVdf>; Tue, 6 Nov 2001 16:33:35 -0500
Received: from mta36-acc.tin.it ([212.216.176.89]:28800 "EHLO fep36-svc.tin.it")
	by vger.kernel.org with ESMTP id <S280593AbRKFVdW>;
	Tue, 6 Nov 2001 16:33:22 -0500
X-Originating-IP: [212.216.68.241]
From: <mikyy@tin.it>
To: linux-kernel@vger.kernel.org
Subject: Invalidate Buffer
Date: Tue, 6 Nov 2001 22:33:15 CET
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20011106213315.CLED4741.fep36-svc.tin.it@[127.0.0.1]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Sorry for my question but I'm not a kernel expert..althought I'm using Linux since 1999 ;)

I am currently running linux 2.4.13 on a reiserfs filesystem configured with LVM version 1.0.1-rc4 (compiled as a module) and I am getting a "invalidate: busy buffer" message but don't know how to investigate because I can't see what is causing it in /var/log/messages and similars..

I am running Suse 7.1 with a "clean" 2.4.13 kernel patched with the last LVM source on an Athlon 750 Mhz (Mb Asus K7V-M) with 256 Mb ram and quantum 20GB HD (plus dvd drive with dxr3 card,hp cd writer plus 8100, sb live soundcard and riva tnt2 video card ).

Please cc to me as I am not subscribed to this list 

Many Thanks and cheers,

Michele

