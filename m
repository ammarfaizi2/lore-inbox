Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVKLMoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVKLMoI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 07:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKLMoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 07:44:08 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:47760 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932198AbVKLMoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 07:44:07 -0500
Date: Sat, 12 Nov 2005 10:14:03 -0200
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com
Subject: [PATCH 0/1] Some fixes to V4L subsystem
Message-Id: <1131799398.6504.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes some makefiles, removes unnecessary typecasts,
renames cx25840 default filenames using the same syntax as DVB and
includes proposed fixes recomended by alsa team.

 drivers/media/video/Makefile                   |    2 
 drivers/media/video/cx25840/cx25840-firmware.c |    2 
 drivers/media/video/saa7127.c                  |   16 
 drivers/media/video/saa7134/Kconfig            |    3 
 drivers/media/video/saa7134/saa7134-alsa.c     |  277 +++++++----------
 5 files changed, 132 insertions(+), 168 deletions(-)


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

