Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSEMAGo>; Sun, 12 May 2002 20:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSEMAGn>; Sun, 12 May 2002 20:06:43 -0400
Received: from jalon.able.es ([212.97.163.2]:10219 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315457AbSEMAGm>;
	Sun, 12 May 2002 20:06:42 -0400
Date: Mon, 13 May 2002 02:06:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: rwhron@earthlink.net
Subject: [PATCHSET] Linux 2.4.19-pre8-jam2
Message-ID: <20020513000631.GA1980@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

New release of this patch set:

- O(1)-sched rml updates
- IDE convert.10
- Re-introduction of wake_up_sync to make pipes run fast again. No idea
  about this is useful or not, that is the point, to test it (Randy ?)

Get it at:


http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre8-jam2.tar.gz
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre8-jam2/


Happy benchmarks !!!

By.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam2 #3 SMP lun may 13 00:49:15 CEST 2002 i686
