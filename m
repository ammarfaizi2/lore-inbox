Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292535AbSBZAGh>; Mon, 25 Feb 2002 19:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292527AbSBZAG1>; Mon, 25 Feb 2002 19:06:27 -0500
Received: from jalon.able.es ([212.97.163.2]:46991 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S292535AbSBZAGN>;
	Mon, 25 Feb 2002 19:06:13 -0500
Date: Tue, 26 Feb 2002 01:06:04 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.18-jam1
Message-ID: <20020226010604.A1744@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Moved to 2.4.18-final. Only change is inclusion of fix for the
binfmt personality change lost in hyperspace between rc4 and final
(matters only in non-x86):

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.18-jam1/
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.18-jam1.tar.gz

By.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-jam1 #1 SMP Tue Feb 26 00:06:55 CET 2002 i686
