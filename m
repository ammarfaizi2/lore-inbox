Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRKNRn4>; Wed, 14 Nov 2001 12:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRKNRnr>; Wed, 14 Nov 2001 12:43:47 -0500
Received: from mail.nep.net ([12.23.44.24]:11026 "HELO nep.net")
	by vger.kernel.org with SMTP id <S274813AbRKNRn1>;
	Wed, 14 Nov 2001 12:43:27 -0500
Message-ID: <19AB8F9FA07FB0409732402B4817D75A125151@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        Lars Magne Ingebrigtsen <larsi@gnus.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Date: Wed, 14 Nov 2001 12:44:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
> Forgive me, but what does 'registered' strictly refer to? It 
> is ECC RAM,
> in a single 512Mb module, but more than that, I don't know.

Okay, i dont know what the difference is, but i can tell you that putting non registered ECC on htat Tyan board is a Bad idea, i did it, the machine was flaky at best. I got reg. ECC and everything is fine.

As far as is this a hardware issue, I run all Athlon machines and have installed redhat on a variaty of boards and chip configuration, and never ahd teh VIA Chipset problems.. I tend to think that there are problems, but they are much agrivated by power cooling, and poor pawer supplies.. 

