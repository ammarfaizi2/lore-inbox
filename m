Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRERR1S>; Fri, 18 May 2001 13:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbRERR07>; Fri, 18 May 2001 13:26:59 -0400
Received: from kivc.vstu.vinnica.ua ([62.244.53.242]:49671 "EHLO
	kivc.vstu.vinnica.ua") by vger.kernel.org with ESMTP
	id <S261255AbRERR0z>; Fri, 18 May 2001 13:26:55 -0400
Date: Fri, 18 May 2001 20:21:11 +0300
From: Bohdan Vlasyuk <bohdan@kivc.vstu.vinnica.ua>
To: linux-kernel@vger.kernel.org
Subject: Q: missing or broken mmap().
Message-ID: <20010518202111.A12397@kivc.vstu.vinnica.ua>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !!

I'm wondering what it may mean - something to be implemented in linux,
of poorly configured system:

---
$ gdb -m dummy -q --batch

warning: mapped symbol tables are not supported on this machine;
missing or broken mmap().
---

When I was reading info, I've seen that "this feature is supported on
chosen platforms", however, I was thinking Linux is the Chosen one
:-)).

Can anyone explain it ??

-- 
Thanks!
