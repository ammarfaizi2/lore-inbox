Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSHXBBB>; Fri, 23 Aug 2002 21:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSHXBBB>; Fri, 23 Aug 2002 21:01:01 -0400
Received: from 205-158-62-92.outblaze.com ([205.158.62.92]:38095 "HELO
	ws3-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S314634AbSHXBBA>; Fri, 23 Aug 2002 21:01:00 -0400
Message-ID: <20020824010451.7526.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "James Hayhurst" <herrdoktor@email.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 23 Aug 2002 20:04:51 -0500
Subject: Annoying messages
X-Originating-Ip: 198.4.83.52
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even with the "quiet" command line option I still get those annoying
"Unknown bridge resource 0: assuming transparent" messages from teh kernel at boot up.  I downloaded the latest pci.ids and recompiled, but it did'nt cure any of my woes.  Any ideas?  I mean, besides commenting out those printk's in pci.c =)

-James

Please CC me directly.
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

