Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292984AbSCJAjS>; Sat, 9 Mar 2002 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292987AbSCJAjI>; Sat, 9 Mar 2002 19:39:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21771 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292984AbSCJAiv>; Sat, 9 Mar 2002 19:38:51 -0500
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Sun, 10 Mar 2002 00:53:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020309233503.GE896@matchmail.com> from "Mike Fedyk" at Mar 09, 2002 03:35:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jrak-00032j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How could I test to kill everything opening glibc and still be able to run a
> command to read /proc/meminfo afterward?

Not easily. Can you give me a precise description of what is running and 
I'll try and duplicate it
