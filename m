Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271839AbTGYAXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271842AbTGYAXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:23:30 -0400
Received: from aneto.able.es ([212.97.163.22]:18659 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271839AbTGYAX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:23:28 -0400
Date: Fri, 25 Jul 2003 00:59:19 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: in-kernel crypto
Message-ID: <20030724225919.GE12002@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Just a couple questions about the crypto routines present in kernel:

- Are they just for in-kernel use, some like encrypted filesystems, or can
  it be used from userspace ?
- It it is usable from userland, has it any advantage over doing it in
  userspace ? IE, for example, can ssh be faster it used the kernel crypto ?
- If so, how ? Special library ? syscalls ?

If this is on a faq everywhere, a pointer is just enough, thanks.

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre7-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
