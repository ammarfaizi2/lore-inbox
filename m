Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRBNSsC>; Wed, 14 Feb 2001 13:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRBNSrw>; Wed, 14 Feb 2001 13:47:52 -0500
Received: from www.ansp.br ([143.108.25.7]:14340 "HELO www.ansp.br")
	by vger.kernel.org with SMTP id <S130392AbRBNSrn>;
	Wed, 14 Feb 2001 13:47:43 -0500
Message-ID: <3A8AC4BD.C37793E6@ansp.br>
Date: Wed, 14 Feb 2001 15:47:41 -0200
From: Marcus Ramos <marcus@ansp.br>
Organization: Fapesp
X-Mailer: Mozilla 4.73 [en] (X11; I; FreeBSD 4.1-RELEASE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: What does "device or resource busy" mean ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I try to load module ttime.o - "insmod ttime.o" - I get the
following message: "ttime.o: init_module: Device or resource busy".
"lsmod" shows that ttime.o was effectively not loaded. I am using RH7
with kernel 2.2.16-22. Does anyone have a guess on a possible reason for
this and how to fix it, so the module can be normally loaded ?

Thanks,
Marcus.

