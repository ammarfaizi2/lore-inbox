Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbSLKUuA>; Wed, 11 Dec 2002 15:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbSLKUuA>; Wed, 11 Dec 2002 15:50:00 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:52744 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267309AbSLKUt7>; Wed, 11 Dec 2002 15:49:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15863.42680.271592.252350@iris.hendrikweg.doorn>
Date: Wed, 11 Dec 2002 21:57:28 +0100
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
From: Kees Bakker <rnews@altium.nl>
Subject: 2.5.51 modprobe bttv hangs
X-Mailer: VM 7.07 under Emacs 20.7.2
Reply-To: Kees Bakker <kees.bakker@xs4all.nl>
Organisation: The Tardis
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.50 and 2.5.51 I get a hanging modprobe if I try to load
bttv. I get all the normal messages from the modules, bt878 and
others, while it loads the modules. But then it hangs. Unfortunately I
haven't got much else to show you. The program does not want to terminate
with ^C. And also an lsmod while this happens is also going to hang.

I'm using module-init-tools-0.9.3. What do I do to get more debug output? 
-- 
============================================================
Kees Bakker
The Tardis
Doorn, The Netherlands                 kees.bakker@xs4all.nl
============================================================
A free society is one where it is safe to be unpopular
