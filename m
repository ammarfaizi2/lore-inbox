Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263964AbRFMMgQ>; Wed, 13 Jun 2001 08:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263966AbRFMMf5>; Wed, 13 Jun 2001 08:35:57 -0400
Received: from scan2.fhg.de ([153.96.1.37]:652 "EHLO scan2.fhg.de")
	by vger.kernel.org with ESMTP id <S263964AbRFMMfq>;
	Wed, 13 Jun 2001 08:35:46 -0400
Date: Wed, 13 Jun 2001 14:35:37 +0200
From: Sven Geggus <geg@iitb.fhg.de>
To: linux-kernel@vger.kernel.org
Subject: Changing CPU Speed while running Linux
Message-ID: <20010613143536.A1323@iitb.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-giggls-priority: very high :P
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

on my Elan410 based System it is very easy to change the CPU clock speed by
means od two outb commands.

I was wondering, if it does some harm to the Kernel if the CPU is
reprogrammed using a different CPU clock speed, while the system is up and
running.

If so, is there a possibility to tell the Kernel that the clock speed has
been changed by means of a particular Kernel call?

If not, where would I put some code to do this at system boot?

Is /usr/src/linux/arch/i386/boot/setup.S the right place for something like
this?

Thanks for hints

Sven

-- 
Sven Geggus @ Fraunhofer IITB, Karlsruhe (http://wsd.iitb.fhg.de/)
Phone: +49 721 6091-422, Fax: +49 721 6091-213
Linux powered DATA aquisition and evaluation, embedded systems,
combustion engine diagnosis
