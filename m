Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280323AbRKXV6w>; Sat, 24 Nov 2001 16:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280320AbRKXV6c>; Sat, 24 Nov 2001 16:58:32 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20840 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S280323AbRKXV62>; Sat, 24 Nov 2001 16:58:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Frederick Thomssen <Thomssen@FreddyAT.net>
To: linux-kernel@vger.kernel.org
Subject: BUG IN KERNEL b2.5.0
Date: Sat, 24 Nov 2001 23:02:25 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E167kod-000697-00@mrvdom01.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
there's a small bug in Kernel b2.5.0:
The Kernel tries to load the nls-iso8859-1 module before mounting the root 
fs...

hope I could help,
Thomssen
-- 
Frederick Thomssen
Bondenwald 49
22453 Hamburg
GERMANY
Tel: +49-40-58976290
Fax: +49-40-58976291
Thomssen@FreddyAT.net
