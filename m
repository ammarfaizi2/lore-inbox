Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSJIU5B>; Wed, 9 Oct 2002 16:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262075AbSJIU5A>; Wed, 9 Oct 2002 16:57:00 -0400
Received: from AGrenoble-101-1-2-94.abo.wanadoo.fr ([193.253.227.94]:2949 "EHLO
	awak") by vger.kernel.org with ESMTP id <S262067AbSJIU5A>;
	Wed, 9 Oct 2002 16:57:00 -0400
Subject: 2.5.41-ac1: Starting migration thread for CPU1
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 23:02:43 +0200
Message-Id: <1034197363.955.5.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Starting migration thread for CPU1" is the last line I see when booting
2.5.41-ac1 on my dual-pIII VIA VP6 (compiled with ACPI, 4G highmem (the
machine has 1.2G))... then it hangs.

more info on request.

