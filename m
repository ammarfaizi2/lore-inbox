Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRALKLH>; Fri, 12 Jan 2001 05:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRALKK5>; Fri, 12 Jan 2001 05:10:57 -0500
Received: from jalon.able.es ([212.97.163.2]:27277 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129511AbRALKKs>;
	Fri, 12 Jan 2001 05:10:48 -0500
Date: Fri, 12 Jan 2001 11:10:39 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: shmfs behaviour
Message-ID: <20010112111039.A2160@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

A couple of questions about shm filesystem:
- Time ago I remember you could see some dot files inside the /dev/shm
  filesystem (then, even it was mounted in /var/shm...). No it shows nothing.
  Is it the supposed behaviour ?
- By accident (switching between 2.2 and 2.4), i left the shm fs 'commented'
  (with a fs type of 'ignore'). Kernel 2.4 looked working good. What is
  /dev/shm for exactly ? Because it looks like I can live without it...

TIA

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac6 #1 SMP Thu Jan 11 11:56:52 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
