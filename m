Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRJNLjq>; Sun, 14 Oct 2001 07:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275094AbRJNLjg>; Sun, 14 Oct 2001 07:39:36 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:40669 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S275082AbRJNLjX>; Sun, 14 Oct 2001 07:39:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: SainTiss <saintiss@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: IRQ conflict
Date: Sun, 14 Oct 2001 13:39:21 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014113949.6ED459C059@pop3.telenet-ops.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm running RH 7.1.94 (roswell) and kernel 2.4.7-2

Every time I boot I get this in my /var/log/messages:

Oct 14 12:18:16 saintpc kernel: IRQ routing conflict for 00:07.2, have irq 5, 
want irq 9

00:07.2 is my USB controller, which I don't use currently, and IRQ 9 is my 
soundcard, which is working fine...

Can something be done about this? Or is this not a 'bad' message?

Thanks in advance

Hans Schippers
