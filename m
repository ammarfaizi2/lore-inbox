Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTEMOV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTEMOV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:21:56 -0400
Received: from sccimhc01.insightbb.com ([63.240.76.163]:39659 "EHLO
	sccimhc01.insightbb.com") by vger.kernel.org with ESMTP
	id S261279AbTEMOVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:21:52 -0400
Message-Id: <5.1.0.14.0.20030513084825.00a8de90@mail.soltec.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 13 May 2003 09:27:34 -0500
To: linux-kernel@vger.kernel.org
From: Steve Fletcher <fletch@soltec.net>
Subject: yenta_socket problems
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am having some problems getting pcmcia working on a laptop  The system is 
an Averatec (formerly Sotec) and has an O2Micro 6912 card controller.  I 
have successfully installed RedHat 8.0 and have installed kernel version 
2.4.18-27.8.0.  Everything seems to work fine, except that when I boot the 
machine, it stops at "Starting pcmcia" for about 5 to 10 minutes.  A check 
of the logs shows no errors. In addition, when I insert a pcmcia card, the 
system hangs for a couple of minutes, then seems fine after that. I have 
tried using the standalone pcmcia drivers, in hopes that would solve my 
problem, but after posting on the forum I was told by David Hinds that I 
should be using yenta_socket.  He suggested I post a message on this list 
to see if anyone has any suggestions.

If you could please CC me on any responses, I would appreciate it.  I would 
subscribe to the list, but I'm afraid I would just be in over my head.  :)

Thanks in advance,

Steve

